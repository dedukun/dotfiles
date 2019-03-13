#!/bin/bash
# Create a new globaltronic project wizard
print_help () { echo "This script helps creating a project."
    echo -e "Usage 'glbt_proj'"
    echo -e "\t-h, --help      Prints help menu"
}

PROJ_FOLDER="$HOME/Globaltronic/Projects"

while [[ $# -gt 0 ]]
do
    PROJ_KEY="$1"

    case $PROJ_KEY in
        -h|--help)
        shift # past argument
        print_help
        exit
        ;;
        *)
        echo "Invalid argument '$1'."
        echo "For more information use argument -h or --help".
        shift # past argument
        exit 1
        ;;
    esac
done

PROJ_NAME=$(echo | dmenu -p "Project Name: ")

[[ -d "$PROJ_FOLDER/$PROJ_NAME" ]] && notify-send -u critical -t 1500 "Project '$PROJ_NAME' already exists!" && exit 1

mkdir -p "$PROJ_FOLDER/$PROJ_NAME"

PROJ_LIST="Manuals\nImages\nCode\nRepos"
PROJ_INPUT=$(echo -e $PROJ_LIST | dmenu -i -p "Input: ")
while : ; do
    if [ "$PROJ_INPUT" == "" ]; then
      break
    fi

    mkdir "$PROJ_FOLDER/$PROJ_NAME/$PROJ_INPUT"
    PROJ_INPUT=$(echo -e $PROJ_LIST | dmenu -p "Input: ")
done

