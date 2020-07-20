#!/bin/sh

##############
## AUXILIAR ##
##############
_run_as_root() {
    # run as root
    if [ ! "$(whoami)" = root ]; then
        # save original home directory
        if [ -z "$usr_name" ]; then
            echo "$USER" >>/tmp/dotfiles-deploy.sh
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
    [ -z "$(getent passwd "$1")" ] && _error "User '$1' doesn't exist." && exit 1
    usr_name="$1"
    usr_home="/home/$usr_name"
}

_error() {
    printf "\033[31mERROR:\033[0m %s\n" "$1"
}

_check_non_free_repositories() {
    if [ $(grep -q "non-free" /etc/apt/sources.list) ]; then
        printf "Contrib and non-free repositories are not active."
        read -r -p "\nThis script needs them to install some of the packages,
want to activate them? [Y/n] " activate_non_free

        if [ $(echo "$activate_non_free" | grep -q -e "^[yY]?$") -gt 0 ]; then
            printf "OK"
        else
            printf "ERROR"
        fi
    fi
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
    f
    # install virtualenvwrapper
    runuser -l "$usr_name" -c "python3 -m pip install --user virtualenvwrapper"
}

_install_nvim_latest() {
    printf "\nInstalling nvim latest...\n"

    # add fuse
    apt install fuse
    modprobe fuse
    groupadd fuse
    usermod -a -G fuse "$user_name"

    runuser -l "$usr_name" -c "mkdir -p $usr_home/.local/bin"
    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -O "$usr_home/.local/bin/nvim" --quiet --show-progress

    # change permissions
    chown "$usr_name:$usr_name" "$usr_home/.local/bin/nvim"
    chmod +x "$usr_home/.local/bin/nvim"

    # add python3 support
    runuser -l "$usr_name" -c "python3 -m pip install --user pynvim"
    runuser -l "$usr_name" -c "python3 -m pip install --user neovim-remote"

    # Install plugs
    runuser -l "$usr_name" -c "$usr_home/.local/bin/nvim -c PlugInstall -c UpdateRemotePlugins -c quit -c quit"

    # shell scripts analysis tool
    apt install shellcheck -y

    # ctags
    apt install exuberant-ctags -y

    # Latex for vimtex
    apt install latexmk -y

    runuser -l "$usr_name" -c "python -m pip install --user pynvim neovim"
    runuser -l "$usr_name" -c "python3 -m pip install --user pynvim neovim"
    runuser -l "$usr_name" -c "npm install -g neovim"
}

_install_st() {
    printf "\nInstalling st...\n"

    # installing x11 headers
    apt install libx11-dev libxft-dev -y

    git clone https://github.com/dedukun/st /tmp/st-dedu
    cd /tmp/st-dedu || {
        _error "Can't cd into '/tmp/st-dedu'"
        return $?
    }

    make install

    cd "$usr_home" || {
        _error "Can't cd into '$usr_home'"
        return $?
    }
    rm -rf /tmp/st-dedu
}

_install_wm() {
    printf "\nInstalling wm...\n"
    apt install bspwm -y
    # apt install i3-wm i3status -y

    # runuser -l "$usr_name" -c "mkdir -p $usr_home/Applications"

    # # xcwd (used in i3 to check the directory of the current terminal)  [Control+mod+Enter]
    # apt install libX11-dev
    # runuser -l "$usr_name" -c "git clone https://github.com/schischi/xcwd.git $usr_home/Applications/xcwd"
    # cd $usr_home/Applications/xcwd || {
    #     _error "Can't cd into '$usr_home/Applications/xcwd'"
    #     return $?
    # }
    # runuser -l "$usr_name" -c "make"
    # make install
    # cd "$usr_home" || {
    #     _error "Can't cd into '$usr_home'"
    #     return $?
    # }

    # # dmenu network manager [mod+F2]
    # runuser -l "$usr_name" -c "git clone https://github.com/firecat53/networkmanager-dmenu.git $usr_home/Applications/networkmanager-dmenu"
}

_install_basics() {
    printf "\nInstalling basics...\n"
    apt install build-essential -y #
    apt install cmake -y           #
    apt install git -y             #
}

_install_extra_packages() {
    printf "\nInstalling extras packages...\n"
    apt install xserver-xorg-input-synaptics -y # synclient (to config touchpad)
    apt install libnotify4 libnotify-bin -y     # notify-send
    apt install suckless-tools -y               # dmenu | slock
    apt install thunderbird -y                  # mail client
    apt install xbacklight -y                   #  xorg-xbacklight
    apt install unclutter -y                    # puts the mouse invisible
    apt install chromium -y                     # chromium to use as secondary browser
    apt install redshift -y                     # reduce blue light (similar f.lux)
    apt install mlocate -y                      # updatedb locate
    apt install xdotool -y                      #
    apt install xtrlock -y                      # lock display leaving windows visible
    apt install zathura -y                      # pdf reader
    apt install wmctrl -y                       #
    apt install xinput -y                       #
    apt install sxhkd -y                        # simple X Hot key daemon
    apt install xclip -y                        # clipboard tool
    apt install htop -y                         # interactive process viewer
    apt install maim -y                         # to take screenshots
    apt install rofi -y                         #
    apt install sxiv -y                         # simple image viewer
    apt install mpv -y                          # media player
}

_install_extra_languages() {
    printf "\nInstalling extras languages...\n"
    apt install default-jre default-jdk -y # Java
    apt install npm -y                     # Node
}

_install_fonts() {
    printf "\nInstalling fonts...\n"
    apt install ttf-unifont \
        fonts-cmu \
        fonts-oldstandard \
        mathematica-fonts \
        msttcorefonts \
        ttf-dejavu \
        ttf-bitstream-vera \
        fonts-powerline \
        fonts-firacode -y
}

_install_dotfiles() {
    printf "\nInstalling dotfiles...\n"

    git clone https://github.com/dedukun/dotfiles /tmp/dotfiles

    chown -R "$usr_name:$usr_name" /tmp/dotfiles

    cd /tmp/dotfiles || {
        _error "Can't cd into '/tmp/dotfiles'"
        return $?
    }

    #find . -maxdepth 1 -name "\.*" -and -not -name ".git*" -type f | tail -n +2 | xargs cp    - "$usr_home"
    #find . -maxdepth 1 -name "\.*" -and -not -name ".git*" -type d | tail -n +2 | xargs cp -r - "$usr_home"
    cp -p -r ".scripts" "$usr_home"
    cp -p ".bashrc" "$usr_home"
    cp -p ".profile" "$usr_home"
    cp -p ".inputrc" "$usr_home"
    cp -p ".xinitrc" "$usr_home"
    cp -p ".screenrc" "$usr_home"
    cp -p ".pythonrc.py" "$usr_home"
    cp -p ".xbindkeysrc" "$usr_home"
    cp -p -r ".config/" "$usr_home"
    cp -p -r ".local/" "$usr_home"
    ln -s "$usr_home/.profile" "$usr_home/.zprofile"
    ln -s "$usr_home/.config/nvim" "$usr_home/.vim"
    ln -s "$usr_home/.config/nvim/init.vim" "$usr_home/.vimrc"

    chmod +x "$usr_home"/.config/polybar/launch.sh
    chmod +x "$usr_home"/.config/bspwm/bspwmrc

    . "$usr_home/.profile"

    systemctl --user enable ssh-agent.service

    cd "$usr_home" || {
        _error "Can't cd into '$usr_home'"
        return $?
    }
    rm -rf /tmp/dotfiles
}

_install_scripts() {
    printf "\nInstalling custom scripts...\n"

    runuser -l "$usr_name" -c "mkdir -p $usr_home/.local/bin"
    usr_scripts="$usr_home/.scripts"
    usr_scripts_bin="$usr_home/.local/bin"

    ln -s "$usr_scripts/other/countdown.sh" "$usr_scripts_bin/countdown"
    ln -s "$usr_scripts/second.sh" "$usr_scripts_bin/csd"
    ln -s "$usr_scripts/display.sh" "$usr_scripts_bin/csm"
    ln -s "$usr_scripts/gbt/logs.sh" "$usr_scripts_bin/glbt_log"
    ln -s "$usr_scripts/gbt/move.sh" "$usr_scripts_bin/glbt_mov"
    ln -s "$usr_scripts/gbt/outputs.sh" "$usr_scripts_bin/glbt_out"
    ln -s "$usr_scripts/gbt/project.sh" "$usr_scripts_bin/glbt_proj"
    ln -s "$usr_scripts/locate_menu.sh" "$usr_scripts_bin/lome"
    ln -s "$usr_scripts/remove_white_spaces.sh" "$usr_scripts_bin/rws"
    ln -s "$usr_scripts/i3/background.sh" "$usr_scripts_bin/mtb"
    ln -s "$usr_scripts/tempdir.sh" "$usr_scripts_bin/mtd"

    # make sure that everything in the user's home is owned by the user
    chown -R "$usr_name:$usr_name" "$usr_home"
}

_uninstall_undesired_packages() {
    apt purge gnome gdm3 lightdm -y
    apt purge evolution -y
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
    _uninstall_undesired_packages
    _install_basics
    _install_extra_packages
    _install_extra_languages
    _install_fonts
    _install_dotfiles
    _install_scripts
    _install_python3
    _install_nvim_latest
    _install_st
    _install_wm
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

    while [ $# -gt 0 ]; do
        dp_key="$1"

        case "$dp_key" in
        -a | --all)
            shift # past argument
            usr_all="True"
            ;;
        -d | --dotfiles)
            shift # past argument
            usr_dot="True"
            ;;
        -u | --user)
            _set_user "$2"
            shift # past argument
            shift # past value
            ;;
        -h | --help)
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

if [ "$usr_all" = "True" ]; then
    install_all
else
    if [ "$usr_dot" = "True" ]; then
        install_dot
    fi
fi

printf "\n\033[1;33mYou need to reboot the machine for the modifications to take effect.\033[0m\n"
