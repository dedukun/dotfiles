#!/bin/sh

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export TERMINAL_OPEN="$TERMINAL --directory"
export TERMINAL_RUN="$TERMINAL "

export STATUSBAR="polybar"
export BROWSER="firefox"
export READER="zathura"
export FILE="ranger"
export PAGER="less"
export CHROME_EXECUTABLE="chromium"

# Paths
export GOPATH="$HOME/.go"
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.npm_global/bin"
PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
PATH="$PATH:/snap/bin"
PATH="$PATH:/usr/local/go/bin"
PATH="$PATH:/opt/flutter/bin"
export PATH

# Projects
export GBT_PROJECTS="$HOME/Globaltronic/Projects"
export LOCAL_BINARIES="$HOME/.local/bin/"
export PERSONAL_PROJECTS="$HOME/Projects"
export SCRIPTS="$HOME/.scripts"

# Configs
export ANDROID_AVD_HOME="$HOME/.android/avd"
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
export BSP_LAYOUT_ROOT="$HOME/Applications/bsp-layout/src"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE="gtk2"
export ZSH_CONFIGS="$HOME/.config/zsh"
export TASKRC="$HOME/.config/task/config"

# locale
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

# export python startup file to add autocomplete to python console
export PYTHONSTARTUP="$HOME/.pythonrc"

# export socket for ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# source aliases
[ -f $HOME/.aliases ] && source "$HOME/.aliases"

# Kill ssh-agent on logout [only run when first sourcing the system at boot]
if ! xset q &>/dev/null; then
    trap 'test -n "$SSH_AUTH_SOCK" && eval `/usr/bin/ssh-agent -k`' 0
fi
