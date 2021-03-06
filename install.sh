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

function setup_vim()
{
    update_link vimrc
    plug_module=~/.vim/autoload/plug.vim
    if [[ ! -e "$plug_module" ]]; then
        # TODO: move this to separate function
        read -r -p "Are you sure you want to download https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim [y/N] " response
        if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
            curl -fLo "$plug_module" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        fi
    fi
    update_link vim/smartmake.rb
    update_link vim/avr/compat.h
    update_link config/nvim/init.vim
}

update_link Xdefaults
update_link bashrc
update_link xinitrc
update_link gitconfig # TODO: should ask for name and e-mail
update_link config/qt5ct/colors/BreezeDark.conf
update_link config/qt5ct/colors/OxygenDark.conf

setup_vim

# awesome window manager
update_link config/awesome/rc.lua
update_link config/awesome/utils.lua
