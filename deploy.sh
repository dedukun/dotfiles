#!/bin/sh

##############
## AUXILIAR ##
##############
_run_as_root() {
    # run as root
    if [ ! "$(whoami)" = root ]; then
        # save original home directory
        if [ -z "$usr_name" ]; then
            echo "$USER" >> /tmp/dotfiles-deploy.sh
        fi
        sudo "$0" "$@"
        exit $?
    fi

    if [ -z "$usr_name" ]; then
        if [ -e /tmp/dotfiles-deploy.sh ]; then
            usr_name="$(cat /tmp/dotfiles-deploy.sh)"
            usr_home="/home/$usr_name"
            rm /tmp/dotfiles-deploy.sh
        else
            usr_name="$USER"
            usr_home="$HOME"
        fi
    fi
    printf "Deploying configs into '%s'...\n" "$usr_home"
}

_set_user() {
    [ -z "$(getent passwd "$1")" ] && _error "User '$1' doens't exist." && exit 1
    usr_name="$1"
    usr_home="/home/$usr_name"
}

_error() {
    printf "\033[31mERROR:\033[0m %s\n" "$1"
}

#######################
## INSTALL FUNCTIONS ##
#######################

_install_python3() {
    printf "\nInstalling python3...\n"

    # install support packages
    apt install python3 python3-pip python3-dev -y

    # upgrade pip
    runuser -l "$usr_name" -c "python3 -m pip install --upgrade pip"

    # install virtualenvwrapper
    runuser -l "$usr_name" -c "python3 -m pip install --user virtualenvwrapper"
}

_install_nvim_latest() {
    printf "\nInstalling nvim latest...\n"

    mkdir -p "$usr_home/.local/bin"
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O "$usr_home/.local/bin/nvim" --quiet --show-progress

    # change permissions
    chown "$usr_name:$usr_name" "$usr_home/.local/bin/nvim"
    chmod +x "$usr_home/.local/bin/nvim"

    # add python3 support
    runuser -l "$usr_name" -c "python3 -m pip install --user pynvim"

    # Install plugs
    runuser -l "$usr_name" -c "$usr_home/.local/bin/nvim -c PlugInstall -c quit -c quit"

    # shell scripts analysis tool
    apt install shellcheck -y

    # ctags
    apt install exuberant-ctags -y

    # Latex for vimtex
    apt install latexmk -y

    # install nauniq (used in custom fzf_history custom command (in .bashrc) to remove repeated entries)
    PERL_MM_USE_DEFAULT=1 perl -MCPAN -e 'install App::nauniq'

    # install youcompleteme completer's
    runuser -l "$usr_name" -c "python3 $usr_home/.vim/plugged/YouCompleteMe/install.py --clang-completer --ts-completer --java-completer"
}

_install_st() {
    printf "\nInstalling st...\n"

    # installing x11 headers
    apt install libx11-dev libxft-dev -y

    git clone https://github.com/lukesmithxyz/st /tmp/st-luke
    cd /tmp/st-luke || { _error "Can't cd into '/tmp/st-luke'"; return $?; }

    make install

    cd "$usr_home" || { _error "Can't cd into '$usr_home'"; return $?; }
    rm -rf /tmp/st-luke
}

_install_i3() {
    printf "\nInstalling i3...\n"
    apt install suckless-tools -y           # dmenu | slock
    apt install i3 -y
}

_install_basics() {
    printf "\nInstalling basics...\n"
    apt install build-essential -y          #
    apt install git -y                      #
    apt install cmake -y                    #
    apt install mlocate -y                  # updatedb/locate
    apt install libnotify4 libnotify-bin -y # notify-send
    apt install zathura xdotool -y          # zathura and xdotool to search forward inside zathura
    apt install xclip -y                    # clipboard tool
    apt install htop -y                     #
}

_install_extras() {
    printf "\nInstalling extras...\n"
    apt install npm -y                      # Node
    apt install default-jre default-jdk -y  # Java
    apt install perl -y                     # Perl
}

_install_dotfiles(){
    printf "\nInstalling dotfiles...\n"

    git clone https://github.com/dedukun/dotfiles /tmp/dotfiles

    chown -R "$usr_name:$usr_name" /tmp/dotfiles

    cd /tmp/dotfiles || { _error "Can't cd into '/tmp/dotfiles'"; return $?; }

    #find . -maxdepth 1 -name "\.*" -and -not -name ".git*" -type f | tail -n +2 | xargs cp    - "$usr_home"
    #find . -maxdepth 1 -name "\.*" -and -not -name ".git*" -type d | tail -n +2 | xargs cp -r - "$usr_home"
    cp -p -r ".scripts" "$usr_home"
    cp -p    ".bashrc"  "$usr_home"
    cp -p    ".profile" "$usr_home"
    cp -p    ".inputrc" "$usr_home"
    cp -p    ".xinitrc" "$usr_home"
    cp -p    ".pythonrc.py" "$usr_home"
    cp -p -r ".config/" "$usr_home"
    cp -p -r ".local/" "$usr_home"
    cp -p    ".vim" "$usr_home"
    cp -p    ".vimrc" "$usr_home"

    . "$usr_home/.profile"

    cd "$usr_home" || { _error "Can't cd into '$usr_home'"; return $?; }
    rm -rf /tmp/dotfiles
}

_install_scripts() {
    printf "\nInstalling custom scripts...\n"

    mkdir -p "$usr_home/.local/bin"
    usr_scripts="$usr_home/.scripts"
    usr_scripts_bin="$usr_home/.local/bin"

    ln -s "$usr_scripts/other/countdown.sh" "$usr_scripts_bin/countdown"
    ln -s "$usr_scripts/second.sh" "$usr_scripts_bin/csd"
    ln -s "$usr_scripts/display.sh" "$usr_scripts_bin/csm"
    ln -s "$usr_scripts/gbt/logs.sh"    "$usr_scripts_bin/glbt_log"
    ln -s "$usr_scripts/gbt/move.sh"   "$usr_scripts_bin/glbt_mov"
    ln -s "$usr_scripts/gbt/outputs.sh" "$usr_scripts_bin/glbt_out"
    ln -s "$usr_scripts/gbt/project.sh" "$usr_scripts_bin/glbt_proj"
    ln -s "$usr_scripts/locate_menu.sh" "$usr_scripts_bin/lome"
}

_uninstall_undesired_packages() {
    apt purge gdm3 gnome lightdm -y
    apt purge evince -y
    apt autoremove -y
}

##############
## COMMANDS ##
##############

print_help() {
    printf "dotfiles deployment utility.\n\n"
    printf "  This script is intended to help install the dotfiles from this repository,\n"
    printf "as well as to setup the whole environment that I use, including the\n"
    printf "desktop environment (i3), as well as some common packages (build-essential,\n"
    printf "java, node, etc) and programs I commonly use (st, nvim, suckless-tools, etc)\n"
    printf "  It will also uninstall undesired packages (gmd3, gnome, etc).\n\n"
    printf "\033[1;33mWARINING: This was written and tested to run on a Debian system, it won't work or\n"
    printf "may have unexpected behaviour on other distributions.\033[0m\n"
    printf "\n  Options:\n"
    printf "\t-a, --all       Installs dotfiles, recommended packages and environments and uninstall undesired packages.\n"
    printf "\t-d, --dotfiles  Only install dotfiles (copies/overwrites dotfiles and symlinks custom scripts).\n"
    printf "\t-u, --user      Destination user.\n"
    printf "\t-h, --help      Prints help menu.\n"
}

install_all() {
    _install_basics
    _install_extras
    _install_dotfiles
    _install_scripts
    _install_python3
    _install_nvim_latest
    _install_st
    _install_i3
    _uninstall_undesired_packages
}

install_dot() {
    _install_dotfiles
    _install_scripts
}

######################
## ARGUMENTS PARSER ##
######################

parse_args() {
    [ $# -lt 1 ] && echo "Need at least one argument!\nFor more information see the '--help' page." && exit 1

    while [ $# -gt 0 ]
    do
        dp_key="$1"

        case "$dp_key" in
            -a|--all)
                shift # past argument
                usr_all="True"
                ;;
            -d|--dotfiles)
                shift # past argument
                usr_dot="True"
                ;;
            -u|--user)
                _set_user "$2"
                shift # past argument
                shift # past value
                ;;
            -h|--help)
                shift # past argument
                print_help
                exit 0
                ;;
            *)
                echo "Invalid argument '$1'."
                echo "For more help use argument -h or --help".
                shift # past argument
                exit 1
                ;;
        esac
    done
}

###################
## MAIN FUNCTION ##
###################

parse_args "$@"

apt update
_run_as_root "$@"

if [ "$usr_all" = "True" ];then
    install_all
elif [ "$usr_dot" = "True" ];then
    install_dot
fi

printf "\n\033[1;33mYou need to reboot the machine for the modifications to take effect.\033[0m\n"
