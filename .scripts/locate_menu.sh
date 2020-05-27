#!/bin/sh
print_help () {
    echo "LOME (Locate Menu)\n"
    echo "This script finds items in the system and pipes the output to dmenu."
    echo "The result of the selection if then passed to a given command."
    echo "(eg. lome <item> <command>) [default command is 'echo']\n"
    echo "Options:"
    echo "\t-l, --lines         Number of lines in dmenu (default: 25)"
    echo "\t-f, --folders       Only search for directories (Uses regex '/<dirname>$')"
    echo "\t-r, --regex         Find items using regex"
    echo "\t-i, --ignore-case   Search case insensetive"
    echo "\t-h, --help          Prints help menu"
    echo "\nRequires: mlocate dmenu vim"
}

lome_lines=25
lome_locate_args=""
lome_command="echo"   # default command

while [ $# -gt 0 ]
do
    lome_key="$1"

    case $lome_key in
        -l|--lines)
            lome_lines=$2
            shift # past argument
            shift # past value
            ;;
        -f|--folders)
            shift # past value
            lome_locate_folder=yes
            lome_locate_args+=" --regex"
            ;;
        -r|--regex)
            shift # past value
            lome_locate_args+=" --regex"
            ;;
        -i|--ignore-case)
            shift # past value
            lome_locate_args+=" -i"
            ;;
        -h|--help)
            shift # past argument
            print_help
            exit 0
            ;;
        [a-zA-Z._]*)
            break # parse the remaining arguments outside the case
            ;;
        *)
            echo "Invalid argument '$1'."
            echo "For more help use argument -h or --help."
            shift # past argument
            exit 1
            ;;
    esac
done

# Get first argument (locate value)
if [ -n $1 ]; then
    lome_locate_value="$1"
else
    echo "No argument locate"
    exit 1
fi

# Get second argument (command)
if [ -n $2 ]; then
    lome_command="$2"

    # Test if the given command exists in the system
    [ ! -n $(command -v "$lome_command") ] \
        && echo -e "The command '$lome_command' doesn't exists in your system.\nTry again with another command." && exit 1
        fi


# Search for folders only
if [ -n $lome_locate_folder ]; then
    lome_locate_value="$lome_locate_value$"
fi

# execute the command
$lome_command "$(locate $lome_locate_args "$lome_locate_value" | rofi -dmenu -i -l "$lome_lines" -p "Lome")"
