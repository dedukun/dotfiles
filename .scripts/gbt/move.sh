#!/bin/bash
print_help () { echo "This script helps organizing compiled images."
    echo -e "Usage '$(basename $0) <file>'"
    echo -e "\t-h, --help      Prints help menu"
}

MOVE_FOLDER="$HOME/Globaltronic/Logging/images"
MOVE_DATE_FOLDER="$(date +%y_%m_%d)"

while [[ $# -gt 0 ]]
do
    MOVE_KEY="$1"

    case $MOVE_KEY in
        -h|--help)
        shift # past argument
        print_help
        exit
        ;;
        [a-zA-Z0-9]*)
        MOVE_FILE=$1
        shift # past argument
        ;;
        *)
        echo "Invalid argument '$1'."
        echo "For more information use argument -h or --help".
        shift # past argument
        exit 1
        ;;
    esac
done

# Check if a file name was given
if [[ ! -n $MOVE_FILE ]]; then
    echo -e "Missing argument.\nYou need to specify the file to move (e.g. gbtm <file>)"
    exit 1
fi

# Check if given file exists
if [[ ! -f $MOVE_FILE ]]; then
    echo -e "File '$MOVE_FILE' doesn't exists.\nFor more information use option -h or --help."
    exit 1
fi

# Create date's folder if it doesn't exists
if [[ ! -d $MOVE_FOLDER/$MOVE_DATE_FOLDER ]]; then
    mkdir "$MOVE_FOLDER/$MOVE_DATE_FOLDER"
fi

# Get custom file name
MOVE_NAME=$(echo | dmenu -p "File name:")

# If no file name is given, use <time>_<file-name>
[[ ! -n $MOVE_NAME ]] && MOVE_NAME=$(date '+%H%M%S')_$MOVE_FILE

mv "$MOVE_FILE" "$MOVE_FOLDER/$MOVE_DATE_FOLDER/$MOVE_NAME"
