#!/bin/sh

#############################################
#======= C O N F I G U R A T I O N S =======#
#############################################

espstart_home="$HOME/Globaltronic/espressiff"
espstart_idfs="$espstart_home/idf"
espstart_tools="$espstart_home/tools"

espstart_env_dir="/tmp/espstart-env"
espstart_env_rc=""
espstart_env_shell=""

#############################################
#=== A U X I L I A R   F U N C T I O N S ===#
#############################################

_list_idfs() {
    ls $espstart_idfs
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

_change_ps1() {
    idf_version="$(echo $1 | tr '[:lower:]' '[:upper:]')"
    echo -n 'export PS1="%}%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})(IDF ' >>"$espstart_env_rc"
    echo -n "$idf_version" >>"$espstart_env_rc"
    echo ') ${prompt_pure_state[prompt]}%f "' >>"$espstart_env_rc"
}

_enable_cmake_colors() {
    echo "export EXTRA_CFLAGS=-fdiagnostics-color=always" >>"$espstart_env_rc"
    echo "export GCC_COLORS='error=01;31:warning=01;35:note=01;36:range1=32:range2=34:locus=01:quote=01:path=01;36:fixit-insert=32:fixit-delete=31:diff-filename=01:diff-hunk=32:diff-delete=31:diff-insert=32:type-diff=01;32'" >>"$espstart_env_rc"
}

#############################################
#============= C O M M A N D S =============#
#############################################

start_idf() {
    _start_env

    _enable_cmake_colors
    _change_ps1 "$1"

    echo "export IDF_TOOLS_PATH='${espstart_tools}/$1'" >>"$espstart_env_rc"
    echo "export IDF_PATH='${espstart_idfs}/$1'" >>"$espstart_env_rc"
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

if [ "$(basename $SHELL)" = "zsh" ]; then
    espstart_env_shell="zsh"
    espstart_env_rc="$espstart_env_dir/.zshrc"
elif [ "$(basename $SHELL)" = "bash" ]; then
    espstart_env_shell="bash"
    espstart_env_rc="$espstart_env_dir/.bashrc"
else
    echo "Unkown shell $(basename $SHELL)"
    exit 1
fi

idfs_count="$(_list_idfs | wc -w)"
choosen_idf="$(_list_idfs | rofi -dmenu -p 'IDF Version:' -l $idfs_count)"

[ -n "$choosen_idf" ] && start_idf "$choosen_idf"
