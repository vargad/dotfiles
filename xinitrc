#!/usr/bin/env bash

# update if Xresources exists
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

[[ -f ~/.xinitrc_local ]] && source ~/.xinitrc_local

exec ck-launch-session dbus-launch --exit-with-session --sh-syntax /usr/bin/awesome
