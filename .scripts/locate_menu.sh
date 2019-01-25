#!/bin/bash
print_help () {
    echo -e "LOME (Locate Menu)\n"
    echo -e "This script finds a items in system and pipes the output to dmenu."
    echo -e "The result of the selection if then passed to a given command."
    echo -e "(eg. lome <item> <command>) [default command is 'vim']\n"
    echo -e "Options:"
    echo -e "\t-l, --lines         Number of lines in dmenu (default: 25)"
    echo -e "\t-n, --no-lines      Don't display dmenu with lines"
    echo -e "\t-f, --folders       Only search for directories (Uses regex '/<dirname>$')"
    echo -e "\t-r, --regex         Find items using regex"
    echo -e "\t-i, --ignore-case   Search case insensetive"
    echo -e "\t-h, --help          Prints help menu"
    echo -e "\nRequires: mlocate dmenu vim"
}

LOME_LINES=25
LOME_LOCATE_ARGS=""

while [[ $# -gt 0 ]]
do
    LOME_KEY="$1"

    case $LOME_KEY in
        -l|--lines)
        LOME_LINES=$2
        shift # past argument
        shift # past value
        ;;
        -n|--no-lines)
        shift # past value
        LOME_NO_LINES=yes
        ;;
        -f|--folders)
        shift # past value
        LOME_LOCATE_FOLDER=yes
        LOME_LOCATE_ARGS+=" --regex"
        ;;
        -r|--regex)
        shift # past value
        LOME_LOCATE_ARGS+=" --regex"
        ;;
        -i|--ignore-case)
        shift # past value
        LOME_LOCATE_ARGS+=" -i"
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
if [[ -n $1 ]]; then
    LOME_LOCATE_VALUE="$1"
else
    echo "No argument locate"
fi

# Get second argument (command)
LOME_COMMAND="vim"
if [[ -n $2 ]]; then
    LOME_COMMAND="$2"

    # Test if the given command exists in the system
    [[ ! -n $(command -v "$LOME_COMMAND") ]] \
        && echo -e "The command '$LOME_COMMAND' doesn't exists in your system.\nTry again with another command." && exit 1
fi


# Search for folders only
if [[ -n $LOME_LOCATE_FOLDER ]]; then
    LOME_LOCATE_VALUE="/$LOME_LOCATE_VALUE$"
fi

if [[ -n $LOME_NO_LINES ]];then
    $LOME_COMMAND "$(locate $LOME_LOCATE_ARGS "$LOME_LOCATE_VALUE" | dmenu -i)"
else
    $LOME_COMMAND "$(locate $LOME_LOCATE_ARGS "$LOME_LOCATE_VALUE" | dmenu -i -l "$LOME_LINES")"
fi
