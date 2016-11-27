# My Virtual Home

Here is my personal settings and configuration files. Take anything you want,
but use at your own risk. Let me know if you have any suggestion to improve.

## Install

Clone my repository to a directory:

    $ git clone https://github.com/vargad/dotfiles

Create symlinks to the configuration files you want to use, or just run my
install.sh script, which creates symlinks (or updates exsiting symlinks):

    $ ./install.sh

Please note that the script does not delete any files. It skips all existing
files (and prints a warning), unless it's a symlink, in that case it updates
the link.
