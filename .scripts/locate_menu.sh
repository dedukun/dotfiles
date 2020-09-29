#!/bin/sh
print_help() {
    printf "LOME (Locate Menu)\n"
    printf "This script finds items in the system and pipes the output to dmenu.\n"
    printf "The result of the selection if then passed to a given command.\n"
    printf "(eg. $0 <item> [<command>]) [default command is 'echo']\n\n"
    printf "Options:\n"
    printf "\t-l, --lines         Number of lines in dmenu (default: 25)\n"
    printf "\t-i, --ignore-case   Search case insensetive\n"
    printf "\t-h, --help          Prints help menu\n"
    printf "\nRequires: mlocate dmenu\n"
}

_exit_error() {
    printf "ERROR: %s\n" "$1" >&2
    exit 1
}

[ -f $HOME/.aliases ] && . $HOME/.aliases

lome_lines=25
lome_locate_args=""
lome_command="echo" # default command

[ $# -eq 0 ] && _exit_error "No arguments"

while [ $# -gt 0 ]; do
    lome_key="$1"

    case $lome_key in
        -l | --lines)
            lome_lines=$2
            shift # past argument
            shift # past value
            ;;
        -i | --ignore-case)
            shift # past value
            lome_locate_args+=" -i"
            ;;
        -h | --help)
            shift # past argument
            print_help
            exit 0
            ;;
        -*)
            _exit_error "Invalid argument '$1'.
       For more help use argument -h or --help."
            ;;
        *)
            break # parse the remaining arguments outside the case
            ;;
    esac
done

# Get first argument (locate value)
if [ -n $1 ]; then
    lome_locate_value="$1"
else
    _exit_error "No argument to locate"
fi

# Get second argument (command)
if [ -n $2 ]; then
    lome_command="$2"

    # Test if the given command exists in the system
    command -v "$lome_command" >/dev/null ||
        _exit_error "The command '$lome_command' doesn't exists in your system.
       Try again with another command."
fi

# execute the command
lome_result="$(kokatu $lome_locate_args $lome_locate_value | rofi -dmenu -i -l $lome_lines -p 'Lome:')"

[ -n $lome_result ] && eval $lome_command "$lome_result"
