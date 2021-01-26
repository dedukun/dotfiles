#!/bin/sh

#############################################
#======= C O N F I G U R A T I O N S =======#
#############################################

espstart_home="$HOME/Globaltronic/espressiff"
espstart_idfs="$espstart_home/idf"
espstart_adfs="$espstart_home/adf"
espstart_tools="$espstart_home/tools"

espstart_env_dir="/tmp/espstart-env"
espstart_env_rc=""
espstart_env_shell=""

espstart_local_settings="./.esp-start.conf"

#############################################
#=== A U X I L I A R   F U N C T I O N S ===#
#############################################

_exit_error() {
    printf "ERROR: %s\n" "$1" >&2
    exit 1
}

_list_idfs() {
    ls $espstart_idfs
}

_list_adfs() {
    ls $espstart_adfs
}

_start_env() {
    mkdir -p "$espstart_env_dir" 2>/dev/null

    printf "#!/bin/sh\n\n" >"$espstart_env_rc"
    [ -f ~/.profile ] && printf ". $HOME/.profile\n" >>"$espstart_env_rc"

    if [ "$espstart_env_shell" = "zsh" ]; then
        [ -f ~/.zshrc ] && printf ". $HOME/.zshrc\n\n" >>"$espstart_env_rc"
    else
        [ -f ~/.bashrc ] && printf ". $HOME/.bashrc\n\n" >>"$espstart_env_rc"
    fi
}

_change_idf_ps1() {
    idf_version="$(echo $1 | tr '[:lower:]' '[:upper:]')"
    echo -n 'export PS1="%}%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})(IDF ' >>"$espstart_env_rc"
    echo -n "$idf_version" >>"$espstart_env_rc"
    echo ') ${prompt_pure_state[prompt]}%f "' >>"$espstart_env_rc"
}

_change_adf_ps1() {
    adf_version="$(echo $1 | tr '[:lower:]' '[:upper:]')"
    echo -n 'export PS1="%}%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})(ADF ' >>"$espstart_env_rc"
    echo -n "$adf_version" >>"$espstart_env_rc"
    echo ') ${prompt_pure_state[prompt]}%f "' >>"$espstart_env_rc"
}

_enable_cmake_colors() {
    echo "export EXTRA_CFLAGS=-fdiagnostics-color=always" >>"$espstart_env_rc"
    echo "export GCC_COLORS='error=01;31:warning=01;35:note=01;36:range1=32:range2=34:locus=01:quote=01:path=01;36:fixit-insert=32:fixit-delete=31:diff-filename=01:diff-hunk=32:diff-delete=31:diff-insert=32:type-diff=01;32'" >>"$espstart_env_rc"
}

_save_settings() {
    save_settings="$(echo 'No\nYes' | rofi -dmenu -l 2 -i -p 'Do you want to save the current settings in this folder?')"

    if [ "$save_settings" = "Yes" ]; then
        notify-send "ESP-Start" "Saved Settings"

        if [ -n "$2" ]; then
            echo "IDF=$1\nADF=$2" >"$espstart_local_settings"
        else
            echo "IDF=$1" >"$espstart_local_settings"
        fi
    fi
}

_load_settings() {
    if [ -f "$espstart_local_settings" ]; then
        load_settings="$(echo 'Yes\nNo' | rofi -dmenu -l 2 -i -p 'Local setting detected. Do you want to load them?')"

        if [ "$load_settings" = "Yes" ]; then
            choosen_idf="$(cat $espstart_local_settings | grep 'IDF=' | cut -d'=' -f2)"
            choosen_adf="$(cat $espstart_local_settings | grep 'ADF=' | cut -d'=' -f2)"

            if [ -n "$choosen_adf" ]; then
                start_adf "$choosen_idf" "$choosen_adf"
            else
                start_idf "$choosen_idf"
            fi
            exit 0
        fi
    fi
}

#############################################
#============= C O M M A N D S =============#
#############################################

start_idf() {
    _start_env

    _enable_cmake_colors
    _change_idf_ps1 "$1"

    echo "export IDF_TOOLS_PATH='${espstart_tools}/$1'" >>"$espstart_env_rc"
    echo "export IDF_PATH='${espstart_idfs}/$1'" >>"$espstart_env_rc"
    echo ". '${espstart_idfs}/$1/export.sh'" >>"$espstart_env_rc"
    if [ "$espstart_env_shell" = "zsh" ]; then
        ZDOTDIR=$espstart_env_dir zsh
    else
        bash --init-file "$espstart_env_rc"
    fi
}

start_adf() {
    _start_env

    _enable_cmake_colors
    _change_adf_ps1 "$2"

    echo "export IDF_TOOLS_PATH='${espstart_tools}/$1'" >>"$espstart_env_rc"
    echo "export IDF_PATH='${espstart_idfs}/$1'" >>"$espstart_env_rc"
    echo "export ADF_PATH='${espstart_adfs}/$2'" >>"$espstart_env_rc"
    echo ". '${espstart_idfs}/$1/export.sh'" >>"$espstart_env_rc"
    if [ "$espstart_env_shell" = "zsh" ]; then
        ZDOTDIR=$espstart_env_dir zsh
    else
        bash --init-file "$espstart_env_rc"
    fi
}

#############################################
#================= M A I N =================#
#############################################

# Check if the using shell is supported
if [ "$(basename $SHELL)" = "zsh" ]; then
    espstart_env_shell="zsh"
    espstart_env_rc="$espstart_env_dir/.zshrc"
elif [ "$(basename $SHELL)" = "bash" ]; then
    espstart_env_shell="bash"
    espstart_env_rc="$espstart_env_dir/.bashrc"
else
    _exit_error "Unsupported shell $(basename $SHELL)"
fi

# Check if there are local settings
_load_settings

idf_or_adf="$(echo 'IDF\nADF' | rofi -dmenu -p 'Choose:' -l 2 -i)"
[ -z "$idf_or_adf" ] && _exit_error "No option was choosen"

if [ "$idf_or_adf" = "IDF" ]; then
    idfs_count="$(_list_idfs | wc -w)"
    choosen_idf="$(_list_idfs | rofi -dmenu -p 'IDF Version:' -l $idfs_count -i)"

    [ -z "$choosen_idf" ] && _exit_error "No IDF was choosen"

    _save_settings "$choosen_idf"

    start_idf "$choosen_idf"
elif [ "$idf_or_adf" = "ADF" ]; then
    adfs_count="$(_list_adfs | wc -w)"
    choosen_adf="$(_list_adfs | rofi -dmenu -p 'ADF Version:' -l $adfs_count -i)"

    [ -z "$choosen_adf" ] && _exit_error "No ADF was choosen"

    idfs_count="$(_list_idfs | wc -w)"
    choosen_idf="$(_list_idfs | rofi -dmenu -p 'IDF Version:' -l $idfs_count -i)"

    [ -z "$choosen_idf" ] && _exit_error "No IDF was choosen"

    _save_settings "$choosen_idf" "$choosen_adf"

    start_adf "$choosen_idf" "$choosen_adf"
else
    _exit_error "Unkown option '$idf_or_adf'"
fi
