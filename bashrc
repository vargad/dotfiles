# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi


# Put your fun stuff here.

function unique_add_to_path() {
    [[ ":$PATH:" != *":$1:"* ]] && PATH="${PATH}:$1"
}

export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
unique_add_to_path "$GEM_HOME/bin"
unique_add_to_path "$GEM_HOME/gems/ruby-lsp-0.8.1/exe"

unique_add_to_path "$HOME/dev/install/bin"
unique_add_to_path "$HOME/dev/tools/rust-analyzer/bin"
unique_add_to_path "/usr/local/bin"
unique_add_to_path "/sbin"
unique_add_to_path "$HOME/.node_modules/bin"
unique_add_to_path "$HOME/.local/bin"
unique_add_to_path "$HOME/.cargo/bin"
unique_add_to_path "$HOME/.gem/ruby/2.5.0/bin"
unique_add_to_path "/var/lib/flatpak/exports/share"
unique_add_to_path "$HOME/.local/share/flatpak/exports/share"
unique_add_to_path "$HOME/dev/tools/flutter/bin"
unique_add_to_path "$HOME/.pulumi/bin"

# source "$HOME/.bash_completion.d/python-argcomplete.sh"

export ANDROID_HOME=/home/dev/tools/android

# add script directory to path
base_dir=$(dirname $(readlink ~/.bashrc))
unique_add_to_path $base_dir/scripts

alias l="ls -l"
alias mv="mv -n"
alias cp="cp -i"

alias icat='kitty +kitten icat'

alias gti=git
alias givm=gvim

alias prettyjson='python -m json.tool'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'
alias webserver='ruby -run -ehttpd .'
alias gnvim='neovide'


function git-copy-with-history()
{
    (
        set -e

        git checkout -b dup

        git mv $1 $2
        git commit -m "duplicate file"

        git checkout HEAD~ $1
        git commit -m "restore file"

        git checkout -

        git merge --no-ff dup

        git branch -d dup
    )
}


export EDITOR=vim
export MAKEFLAGS="-j4"

# append to history every time a command is entered
PROMPT_COMMAND='history -a'
# don't put commands starting with space to history, also ignore duplicates
HISTCONTROL=ignoreboth

# enter directories without cd command
shopt -s autocd

if [[ -f $HOME/.bashrc_local ]] ; then
    source $HOME/.bashrc_local
fi

unset unique_add_to_path
