import os
import re
import subprocess
from shlex import split
from time import sleep, time

LAZY_COMMAND = "nvim --headless +\"lua require('lazy').update()\""
MASON_LIST_COMMAND = "nvim --headless +\"lua print(vim.inspect(require('mason.settings').current.ensure_installed)); vim.api.nvim_command('quit')\""  # noqa: E501
INSTALL_LSP_COMMAND = (
    "nvim --headless +\"lua require('mason-lspconfig.ensure_installed')()\""
)
proc = subprocess.Popen(
    split(LAZY_COMMAND), stderr=subprocess.PIPE, stdout=subprocess.PIPE
)

assert proc.stderr is not None
output_fd = proc.stderr.fileno()


def wait_for(fd, regex: re.Pattern, timeout):
    start_time = time()
    all_output = ""
    while True:
        output = os.read(fd, 1024).decode("utf-8")
        print(output)
        all_output += output
        matches = regex.findall(all_output)

        if matches:
            return matches
        elif time() - start_time > timeout:
            raise RuntimeError("neovim update did not execute correctly.")
        else:
            sleep(0.1)


num_grammers = int(
    wait_for(
        output_fd, re.compile(r"\[nvim-treesitter] \[\d+/(?P<num_grammers>\d+)].+"), 300
    )[0]
)
print(f"WAITING FOR {num_grammers}")
wait_for(
    output_fd,
    re.compile(
        r"\[nvim-treesitter] \[{num_grammers}/".format(num_grammers=num_grammers)
    ),
    300,
)

proc_mason = subprocess.Popen(
    split(MASON_LIST_COMMAND), stderr=subprocess.PIPE, stdout=subprocess.PIPE
)
_, nvim_output = proc_mason.communicate(timeout=10)  # nvim sends output to stderr
mason_plugins = set(re.findall(r'"(\w+)"', str(nvim_output)))

state_dir = os.environ["XDG_STATE_HOME"]
mason_log_file = f"{state_dir}/nvim/mason.log"
while not os.path.isfile(mason_log_file):
    sleep(1)


installed_plugins = set()
waiting_time = 0
with open(f"{state_dir}/nvim/mason.log", "r") as log_file:
    while not mason_plugins.issubset(installed_plugins):
        new_lines = log_file.read()
        if not new_lines:
            sleep(0.1)
            waiting_time += 0.1
            if waiting_time > 300:
                raise RuntimeError("neovim update did not finish in time")
            continue

        print(new_lines)
        mason_plugins.update(
            re.findall(r"Executing installer for Package\(name=(\S+)\)", new_lines)
        )
        print(f"needed plugins are: {mason_plugins}")
        installed_plugins.update(
            re.findall(r"Installation succeeded for Package\(name=(\S+)\)", new_lines)
        )
        print(f"installed plugins are: {installed_plugins}")

proc.terminate()

proc_install_lsp = subprocess.Popen(split(INSTALL_LSP_COMMAND), stdout=subprocess.PIPE, stderr=subprocess.PIPE)

assert proc_install_lsp.stderr is not None
install_lsp_output_fd = proc_install_lsp.stderr.fileno()

to_install = set()
installed = set()
all_output = ""
while not to_install or (not to_install.issubset(installed)):
    new_text = os.read(install_lsp_output_fd, 256).decode('utf-8')
    all_output += new_text
    if not new_text:
        sleep(0.1)
        waiting_time += 0.1
        if waiting_time > 300:
            proc_install_lsp.kill()
            raise RuntimeError("neovim update did not finish in time")
        continue

    print(new_text)

    to_install.update(re.findall(r" installing (\S+)\[", all_output))
    print(f"to install: {to_install}")
    installed.update(re.findall(r" (\S+) was successfully installed", all_output))
    print(f"installed: {installed}")

proc_install_lsp.terminate()

