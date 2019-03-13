#!/bin/bash
# .bash_profile

# Exports
export PATH="$PATH:$HOME/.local/bin"
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"
export FILE="ranger"

export GBT_PROJECTS="$HOME/Globaltronic/Projects"
export SCRIPTS="$HOME/.scripts"

# start ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s`
    ssh-add
fi

## Run bashrc
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Kill ssh-agent on logout
trap 'test -n "$SSH_AUTH_SOCK" && eval `/usr/bin/ssh-agent -k`' 0
