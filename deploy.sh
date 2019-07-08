#!/bin/sh

_error() {
    printf "\033[31mERROR:\033[0m %s\n" "$1"
}

_install_python3() {
    printf "\nInstalling python3...\n"

    # install support packages
    apt install python3 python3-pip python3-dev -y

    # Upgrade pip
    python3 -m pip install --upgrade pip
}

_install_mpsyt() {
    printf "\nInstalling mpsyt...\n"

    # install virtualenvwrapper
    python3 -m pip install virtualenvwrapper

    workonenv
    mkvirutalenv youtube
    "$WORKON_usr_home/youtube/bin/pip install youtube-dl"
    "$WORKON_usr_home/youtube/bin/pip install dbus-python pygobject"
    "$WORKON_usr_home/youtube/bin/pip install mps-youtube"
}

_install_nvim() {
    printf "\nInstalling nvim...\n"

    python3 -m install neovim

    mkdir -p "$usr_home/.local/bin"
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O "$usr_home/.local/bin/nvim" --quiet --show-progress

    # Install plugs
    nvim -c PlugInstall -c quit -c quit

    # Install youcompleteme
    apt install cmake -y

    cd "$usr_home/.vim/plugged/YouCompleteMe" || { _error "Can't cd into '$HOME/.vim/plugged/YouCompleteMe'"; return $?; }
    python3 install.py --clang --ts-completer --java-completer

    cd "$usr_home" || { _error "Can't cd into '$HOME'"; return $?; }
}

_install_st() {
    printf "\nInstalling st...\n"
    # installing x11 headers
    apt install libx11-dev libxft-dev -y

    git clone https://github.com/lukesmithxyz/st /tmp/st-luke
    cd /tmp/st-luke || { _error "Can't cd into '/tmp/st-luke'"; return $?; }

    make install

    cd "$usr_home" || { _error "Can't cd into '$HOME'"; return $?; }
    rm -rf /tmp/st-luke
}

_install_i3() {
    printf "\nInstalling i3...\n"
    apt install i3 -y
}

_install_basics() {
    printf "\nInstalling basics...\n"
    apt update
    apt install build-essential git -y
    apt install node npm -y
    apt install default-jre default-jdk -y
}

_install_dotfiles(){
    printf "\nInstalling dotfiles...\n"
    git clone https://github.com/dedukun/dotfiles /tmp/dotfiles
    cd /tmp/dotfiles || { _error "Can't cd into '/tmp/dotfiles'"; return $?; }

    cp -r ".scripts" "$usr_home"
    cp    ".bashrc"  "$usr_home"
    cp    ".profile" "$usr_home"
    cp    ".inputrc" "$usr_home"
    cp    ".xinitrc" "$usr_home"
    cp    ".pythonrc.py" "$usr_home"
    cp -r ".config/" "$usr_home"
    cp -r ".local/" "$usr_home"

    . "$usr_home/.profile"

    cd "$usr_home" || { _error "Can't cd into '$HOME'"; return $?; }
    rm -rf /tmp/dotfiles
}

###################
## MAIN FUNCTION ##
###################

# run as root
if [ ! "$(whoami)" = root ]; then
    # save original home directory
    echo "$HOME" >> /tmp/dotfiles-deploy.sh
    sudo "$0" "$@"
    exit $?
fi

if [ -e /tmp/dotfiles-deploy.sh ]; then
    usr_home="$(cat /tmp/dotfiles-deploy.sh)"
    rm /tmp/dotfiles-deploy.sh
else
    usr_home="$HOME"
fi

printf "Deploying configs into '%s'...\n" "$usr_home"

_install_basics
_install_dotfiles
_install_python3
_install_mpsyt
_install_nvim
_install_st
_install_i3

printf "\nYou need to reboot the machine to enable the  modifications.\n"
