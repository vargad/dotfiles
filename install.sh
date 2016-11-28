#!/usr/bin/env bash

set -e

function update_link()
{
    dest="$HOME/.$1"
    dest_dir=$(dirname "${dest}")
    mkdir -p "$dest_dir"
    if [[ ! -e $dest || -L $dest ]]; then
        echo "Updating $dest"
        ln -sf "`readlink -f $1`" $dest
    else
        echo "File already exists: $dest"
    fi
}

update_link Xdefaults
update_link bashrc
update_link xinitrc
update_link gitconfig # TODO: should ask for name and e-mail

# awesome window manager
update_link config/awesome/rc.lua
update_link config/awesome/utils.lua
