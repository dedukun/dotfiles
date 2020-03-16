#!/bin/sh

# Default programs
export EDITOR="nvim"
# export TERMINAL="st"
export TERMINAL="alacritty"
export TERMINAL_OPEN="alacritty --working-directory"
export BROWSER="firefox"
export READER="zathura"
export FILE="ranger"
export PAGER="less"

# Exports
export GOPATH="$HOME/.go"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.npm_global/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export ANDROID_AVD_HOME="$HOME/.android/avd"

export ZSH_CONFIGS="$HOME/.config/zsh"
export GBT_PROJECTS="$HOME/Globaltronic/Projects"
export SCRIPTS="$HOME/.scripts"
export LOCAL_BINARIES="$HOME/.local/bin/"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# locale
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

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

export PATH="$HOME/.cargo/bin:$PATH"
