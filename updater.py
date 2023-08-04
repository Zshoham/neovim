import subprocess
from time import time
import re
import os
from time import sleep
from shlex import split

LAZY_COMMAND = "nvim --headless +\"lua require('lazy').install()\""
MASON_LIST_COMMAND = "nvim --headless +\"lua print(vim.inspect(require('mason.settings').current.ensure_installed)); vim.api.nvim_command('quit')\""

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

print("BEFORE MASON")
proc_mason = subprocess.Popen(
    split(MASON_LIST_COMMAND), stderr=subprocess.PIPE, stdout=subprocess.PIPE
)
_, nvim_output = proc_mason.communicate(timeout=10)  # nvim sends output to stderr
mason_plugins = set(re.findall(r'"(\w+)"', str(nvim_output)))
print("AFTER MASON")

home_dir = os.environ["HOME"]
mason_log_file = f"{home_dir}/.local/state/nvim/mason.log"
while not os.path.isfile(mason_log_file):
    sleep(1)

print("AHHHHHHHHHHHH")
installed_plugins = set()
waiting_time = 0
with open(f"{home_dir}/.local/state/nvim/mason.log", "r") as log_file:
    print("OKKKKKKK")
    while mason_plugins.issubset(installed_plugins):
        new_lines = log_file.read()
        print(new_lines)
        if not new_lines:
            sleep(0.1)
            waiting_time += 0.1
            if waiting_time > 300:
                raise RuntimeError("neovim update did not finish in time")
            continue
        
        installed_plugins.update(
            re.findall(r"Installation succeeded for Package\(name=(\w+)\)", new_lines)
        )
        print(f"installed plugins are: {installed_plugins}")

