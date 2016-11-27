function update_link()
{
    dest="$HOME/.$1"
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
update_link gitconfig

# awesome window manager
update_link config/awesome/rc.lua
update_link config/awesome/utils.lua
