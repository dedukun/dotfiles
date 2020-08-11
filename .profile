#!/bin/sh

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="alacritty"
export TERMINAL_OPEN="$TERMINAL --working-directory"
export TERMINAL_RUN="$TERMINAL --command"
export BROWSER="firefox"
export READER="zathura"
export FILE="ranger"
export PAGER="less"

# Paths
export GOPATH="$HOME/.go"
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.npm_global/bin"
PATH="$PATH:/snap/bin"
PATH="$PATH:/usr/local/go/bin"
export PATH

# Projects
export GBT_PROJECTS="$HOME/Globaltronic/Projects"
export PERSONAL_PROJECTS="$HOME/Projects"
export SCRIPTS="$HOME/.scripts"
export LOCAL_BINARIES="$HOME/.local/bin/"

# Configs
export ANDROID_AVD_HOME="$HOME/.android/avd"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export ZSH_CONFIGS="$HOME/.config/zsh"
export QT_STYLE_OVERRIDE="gtk2"

# locale
export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

# export python startup file to add autocomplete to python console
export PYTHONSTARTUP="$HOME/.pythonrc.py"

# export socket for ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

## Run bashrc
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Kill ssh-agent on logout
trap 'test -n "$SSH_AUTH_SOCK" && eval `/usr/bin/ssh-agent -k`' 0
