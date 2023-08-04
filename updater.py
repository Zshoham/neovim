import subprocess
from time import time
import re
import os
from time import sleep
from shlex import split

LAZY_COMMAND = "nvim --headless +\"lua require('lazy').install()\""
MASON_COMMAND = 'nvim --headless +"Lazy load mason.nvim"'

proc = subprocess.Popen(
    split(LAZY_COMMAND), stderr=subprocess.PIPE, stdout=subprocess.PIPE
)

assert proc.stderr is not None
output_fd = proc.stderr.fileno()


def wait_for(regex: re.Pattern, timeout):
    start_time = time()
    while True:
        output = os.read(output_fd, 1024).decode("utf-8")
        print(output)
        matches = regex.findall(output)

        if matches:
            return matches
        elif time() - start_time > timeout:
            raise RuntimeError("neovim update did not execute correctly.")
        else:
            sleep(0.1)


num_grammers = int(
    wait_for(re.compile(r"\[nvim-treesitter] \[\d+/(?P<num_grammers>\d+)].+"), 300)[0]
)
wait_for(
    re.compile(
        r"\[nvim-treesitter] \[{num_grammers}/".format(num_grammers=num_grammers)
    ),
    300,
)

proc.terminate()
proc.wait(timeout=10)

proc = subprocess.Popen(split(MASON_COMMAND))

sleep(1)
print("searching for curl process.")
while os.popen("pgrep curl").read():
    print("curl found.")
    sleep(1)

proc.terminate()
proc.wait(timeout=10)
