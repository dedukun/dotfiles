#!/bin/sh

#XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export HISTFILE="${XDG_STATE_HOME}/bash/history"
export ANDROID_HOME="$XDG_DATA_HOME/android"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"

export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export TERMINAL_OPEN="$TERMINAL --directory"
export TERMINAL_RUN="$TERMINAL "

export STATUSBAR="polybar"
export BROWSER="firefox"
export READER="zathura"
export FILE="joshuto"
export PAGER="moar"
export CHROME_EXECUTABLE="chromium"
export DIFFPROG="nvim -d"

# Paths
export GOPATH="$HOME/.go"
PATH="$PATH:$GOPATH/bin"
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.npm_global/bin"
PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
PATH="$PATH:$HOME/nRF52/gcc-arm/bin"
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
export ANDROID_SDK_ROOT="/opt/android-sdk"
export BSP_LAYOUT_ROOT="$HOME/Applications/bsp-layout/src"
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE="gtk2"
export ZSH_CONFIGS="$HOME/.config/zsh"
export TASKRC="$HOME/.config/task/config"
export ZEPHYR_SDK_INSTALL_DIR="$HOME/Globaltronic/zephyr/sdk/zephyr-sdk-0.15.1"

# export socket for ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# source aliases
[ -f $HOME/.aliases ] && source "$HOME/.aliases"

# Kill ssh-agent on logout [only run when first sourcing the system at boot]
if ! xset q &>/dev/null; then
    trap 'test -n "$SSH_AUTH_SOCK" && eval `/usr/bin/ssh-agent -k`' 0
fi

. "/home/dedukun/.local/share/cargo/env"
