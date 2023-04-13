#!/usr/bin/env bash

# update if Xresources exists
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

[[ -f ~/.xinitrc_local ]] && source ~/.xinitrc_local

export QT_QPA_PLATFORMTHEME="qt5ct"
export CARGO_TARGET_DIR="/home/vargad/dev/cache/cargo"

exec dbus-launch --exit-with-session --sh-syntax /usr/bin/awesome
