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

unique_add_to_path "/usr/local/bin"
unique_add_to_path "/sbin"
unique_add_to_path "$HOME/.node_modules/bin"

# add script directory to path
base_dir=$(dirname $(readlink ~/.bashrc))
unique_add_to_path $base_dir/scripts

alias l="ls -l"
alias mv="mv -n"
alias cp="cp -i"

alias prettyjson='python -m json.tool'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote_plus(sys.argv[1])"'

export MAKEFLAGS="-j4"

PROMPT_COMMAND='history -a'
HISTCONTROL=ignoreboth

shopt -s autocd

if [[ -f $HOME/.bashrc_local ]] ; then
    source $HOME/.bashrc_local
fi

unset unique_add_to_path
