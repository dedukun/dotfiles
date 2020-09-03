#!/bin/sh
#[WIP]
print_help() {
    echo "This script helps organizing compiled images."
    printf "Usage '%s' <file>\n" "$(basename "$0")"
    printf "\t-h, --help      Prints help menu\n"
}

move_folder="$HOME/Globaltronic/Logging/images"
move_date_folder="$(date +%y_%m_%d)"

while [ $# -gt 0 ]; do
    move_key="$1"

    case $move_key in
        -h | --help)
            shift # past argument
            print_help
            exit
            ;;
        [a-zA-Z0-9]*)
            move_file=$1
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
if [ ! -n "$move_file" ]; then
    printf "Missing argument.\nYou need to specify the file to move (e.g. gbtm <file>)"
    exit 1
fi

# Check if given file exists
if [ ! -f "$move_file" ]; then
    printf "File '%s' doesn't exists.\nFor more information use option -h or --help.\n" "$move_file"
    exit 1
fi

# Create date's folder if it doesn't exists
if [ ! -d "$move_folder/$move_date_folder" ]; then
    mkdir "$move_folder/$move_date_folder"
fi

# Get custom file name
move_name=$(echo | rofi -dmenu -p "File name:")

# If no file name is given, use <time>_<file-name>
[ ! -n "$move_name" ] && move_name=$(date '+%H%M%S')_$move_file

mv "$move_file" "$move_folder/$move_date_folder/$move_name"
