#!/usr/bin/env bash

# update if Xresources exists
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

[[ -f ~/.xinitrc_local ]] && source ~/.xinitrc_local

export XDG_MENU_PREFIX=kf5-
export QT_QPA_PLATFORMTHEME="qt6ct"
export CARGO_TARGET_DIR="/home/vargad/dev/cache/cargo"
export LIBTORCH=/home/dev/tools/libtorch

if [[ -f $HOME/.xinitrc_local ]] ; then
    source $HOME/.xinitrc_local
fi

source ~/.setpaths

exec dbus-launch --exit-with-session --sh-syntax /usr/bin/awesome
