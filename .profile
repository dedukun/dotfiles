#!/bin/sh

# Default programs
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"
export FILE="ranger"

# Exports
export GOPATH="$HOME/.go"
export PATH="$PATH:$HOME/.local/bin:$HOME/.npm_global/bin:/usr/local/go/bin:$GOPATH/bin"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export ANDROID_AVD_HOME="$HOME/.android/avd"

export GBT_PROJECTS="$HOME/Globaltronic/Projects"
export SCRIPTS="$HOME/.scripts"

# locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# export python startup file to add autocomplete to python console
export PYTHONSTARTUP="$HOME/.pythonrc.py"

# start ssh-agent
if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    ssh-add ~/.ssh/gbt_rsa
fi

## Run bashrc
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Kill ssh-agent on logout
trap 'test -n "$SSH_AUTH_SOCK" && eval `/usr/bin/ssh-agent -k`' 0
