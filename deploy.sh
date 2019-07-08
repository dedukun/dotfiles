#!/bin/sh

_error() {
    printf "\033[31mERROR:\033[0m %s" "$1"
}

_install_python3() {
    echo "Installing python3..."

    # install support packages
    apt install python3 python3-pip python3-dev

    # Upgrade pip
    python3 -m pip install --upgrade pip
}

_install_mpsyt() {
    echo "Installing mpsyt..."

    # install virtualenvwrapper
    python3 -m pip install virtualenvwrapper

    workonenv
    mkvirutalenv youtube
    "$WORKON_HOME/youtube/bin/pip install youtube-dl"
    "$WORKON_HOME/youtube/bin/pip install dbus-python pygobject"
    "$WORKON_HOME/youtube/bin/pip install mps-youtube"
}

_install_nvim() {
    echo "Installing nvim..."
    mkdir -p "$HOME/.local/bin"
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O "$HOME/.local/bin/nvim" --quiet --show-progress
}

_install_st() {
    echo "Installing st..."
    git clone https://github.com/lukesmithxyz/st /tmp/st-luke
    cd /tmp/st-luke || { _error "Can't cd into '/tmp/st-luke'"; return $?; }

    make
    make install

    cd "$HOME" || { _error "Can't cd into '$HOME'"; return $?; }
    rm -rf /tmp/st-luke
}

_install_basics() {
    echo "Installing basics..."
    apt update
    apt install build-essential git
}

_install_configs(){
    git clone https://github.com/lukesmithxyz/st /tmp/dotfiles
    cd /tmp/dotfiles || { _error "Can't cd into '/tmp/dotfiles'"; return $?; }

    cp -r ".scripts" "$HOME"
    cp    ".bashrc"  "$HOME"
    cp    ".profile" "$HOME"
    cp    ".inputrc" "$HOME"
    cp    ".xinitrc" "$HOME"
    cp    ".pythonrc.py" "$HOME"
    cp -r ".config/" "$HOME"
    cp -r ".local/" "$HOME"

    source "$HOME/.profile"

    cd "$HOME" || { _error "Can't cd into '$HOME'"; return $?; }
    rm -rf /tmp/dotfiles
}

# run as root
[ "$(whoami)" = root ] || { sudo "$0" "$@"; exit $?; }

_install_basics
_install_configs
_install_python3
_install_mpsyt
_install_nvim
_install_st
