#!/bin/sh
# Manages GBT projects.
print_help () {
    echo "This script helps creating a project and manage it."
    printf "Usage '%s'\n" "$(basename "$0")"
    printf "\t-n, --new       Create a new project\n"
    printf "\t-c, --choose    Choose the current working project\n"
    printf "\t-s, --show      Show the current project\n"
    printf "\t-g, --get       Get the current project\n"
    printf "\t-h, --help      Prints help menu\n"
}

new_project () {
    PROJ_NAME=$(echo | dmenu -p "Project Name: ")

    [ "$PROJ_NAME" = "" ] && exit 0

    [ -d "$PROJ_FOLDER/$PROJ_NAME" ] && notify-send -u critical -t 1500 "Project '$PROJ_NAME' already exists!" && exit 1

    mkdir -p "$PROJ_FOLDER/$PROJ_NAME"

    PROJ_ID=$(grep -e "^id=" "$SCRIPTS/.config/.gbt_project" | sed 's/id=\s*// g')
    echo "$PROJ_ID" > "$PROJ_FOLDER/$PROJ_NAME/.id"
    sed -i "s/id=.*$/id=$((PROJ_ID+1))/ g" "$SCRIPTS/.config/.gbt_project"

    PROJ_LIST="Code\nRepos\nManuals\nDocumentation\nImages\nSchematics\nPictures"
    PROJ_INPUT=$(printf "%s" "$PROJ_LIST" | dmenu -i -p "Input: ")
    while true ; do
        if [ "$PROJ_INPUT" = "" ]; then
          break
        fi

        mkdir "$PROJ_FOLDER/$PROJ_NAME/$PROJ_INPUT"
        PROJ_INPUT=$(printf "%s" "$PROJ_LIST" | dmenu -p "Input: ")
    done
}

choose_project () {
    PROJ_NAME=$(find "$PROJ_FOLDER" -maxdepth 1 -type d | sort | tail -n +2 | xargs -n 1 -I @ sh -c 'echo `basename "@"`' | dmenu -i -p "Choose Project: ")
    PROJ_FULL_NAME="$PROJ_NAME"
    while [ ! -f "$PROJ_FOLDER/$PROJ_FULL_NAME/.id" ]
    do
        PROJ_NAME=$(find "$PROJ_FOLDER/$PROJ_FULL_NAME" -maxdepth 1 -type d | sort | tail -n +2 | xargs -n 1 -I @ sh -c 'echo `basename "@"`' | dmenu -i -p "Choose Project: ")
        PROJ_FULL_NAME="$PROJ_FULL_NAME/$PROJ_NAME"
    done

    sed -i "s/proj=.*$/proj=$(echo "$PROJ_FULL_NAME" | sed 's/\//\\\// g')/ g" "$SCRIPTS/.config/.gbt_project"

    notify-send -t 1500 "Project '$PROJ_FULL_NAME' was selected."
}

show_project () {
    PROJ_NAME=$(grep -e "^proj=" "$SCRIPTS/.config/.gbt_project" | sed 's/proj=\s*// g')

    notify-send -t 1500 "Current project is '$PROJ_NAME'."
}

get_project () {
    PROJ_NAME=$(grep -e "^proj=" "$SCRIPTS/.config/.gbt_project" | sed 's/proj=\s*// g')

    echo "$GBT_PROJECTS/$PROJ_NAME"
}

PROJ_FOLDER="$GBT_PROJECTS"

while [ $# -gt 0 ]
do
    PROJ_KEY="$1"

    case $PROJ_KEY in
        -n|--new)
        shift # past argument
        new_project
        exit 0
        ;;
        -c|--choose)
        shift # past argument
        choose_project
        exit 0
        ;;
        -s|--show)
        shift # past argument
        show_project
        exit 0
        ;;
        -g|--get)
        shift # past argument
        get_project
        exit 0
        ;;
        -h|--help)
        shift # past argument
        print_help
        exit 0
        ;;
        *)
        echo "Invalid argument '$1'."
        echo "For more information use argument -h or --help".
        shift # past argument
        exit 1
        ;;
    esac
done
