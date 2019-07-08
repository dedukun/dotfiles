#!/bin/sh

_error() {
    printf "\033[31mERROR:\033[0m %s\n" "$1"
}

_install_python3() {
    printf "\nInstalling python3...\n"

    # install support packages
    apt install python3 python3-pip python3-dev

    # Upgrade pip
    python3 -m pip install --upgrade pip
}

_install_mpsyt() {
    printf "\nInstalling mpsyt...\n"

    # install virtualenvwrapper
    python3 -m pip install virtualenvwrapper

    workonenv
    mkvirutalenv youtube
    "$WORKON_HOME/youtube/bin/pip install youtube-dl"
    "$WORKON_HOME/youtube/bin/pip install dbus-python pygobject"
    "$WORKON_HOME/youtube/bin/pip install mps-youtube"
}

_install_nvim() {
    printf "\nInstalling nvim...\n"
    mkdir -p "$HOME/.local/bin"
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O "$HOME/.local/bin/nvim" --quiet --show-progress
}

_install_st() {
    printf "\nInstalling st...\n"
    # installing x11 headers
    apt install libx11-dev libxft-dev

    git clone https://github.com/lukesmithxyz/st /tmp/st-luke
    cd /tmp/st-luke || { _error "Can't cd into '/tmp/st-luke'"; return $?; }

    make install

    cd "$HOME" || { _error "Can't cd into '$HOME'"; return $?; }
    rm -rf /tmp/st-luke
}

_install_basics() {
    printf "\nInstalling basics...\n"
    apt update
    apt install build-essential git
}

_install_dotfiles(){
    printf "\nInstalling dotfiles...\n"
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
_install_dotfiles
_install_python3
_install_mpsyt
_install_nvim
_install_st

printf "\nYou need to reboot the machine to enable the  modifications.\n"
