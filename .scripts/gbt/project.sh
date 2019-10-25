#!/bin/sh
# Manages GBT projects.
print_help () {
    echo "This script helps creating a project and manage it."
    printf "Usage '%s'\n" "$(basename "$0")"
    printf "\t-n, --new            Create a new project\n"
    printf "\t    --create-folders Create folders for current working project\n"
    printf "\t-c, --choose         Choose the current working project\n"
    printf "\t    --choose-all     Choose the current working project from all\n"
    printf "\t-s, --show           Show the current project\n"
    printf "\t-g, --get            Get the full path to the current working project\n"
    printf "\t-h, --help           Prints help menu\n"
}

new_project () {
    PROJ_NAME=$(echo | dmenu -p "Project Name: ")

    [ "$PROJ_NAME" = "" ] && exit 0

    [ -d "$PROJ_FOLDER/$PROJ_NAME" ] && notify-send -u critical -t 1500 "Project '$PROJ_NAME' already exists!" && exit 1

    mkdir -p "$PROJ_FOLDER/$PROJ_NAME"

    PROJ_ID=$(grep -e "^id=" "$SCRIPTS/.config/.gbt_project" | sed 's/id=\s*// g')
    echo "$PROJ_ID" > "$PROJ_FOLDER/$PROJ_NAME/.id"
    sed -i "s/id=.*$/id=$((PROJ_ID+1))/ g" "$SCRIPTS/.config/.gbt_project"

    create_folders "$PROJ_NAME"
}

create_folders () {
    if [ -n "$1" ]; then
        PROJ_NAME="$1"
    else
        PROJ_NAME=$(private_get_project)
    fi
    PROJ_INPUT=$(private_get_unused_directories "$PROJ_FOLDER/$PROJ_NAME")
    while true ; do
        if [ "$PROJ_INPUT" = "" ]; then
          break
        fi

        mkdir "$PROJ_FOLDER/$PROJ_NAME/$PROJ_INPUT"
        PROJ_INPUT=$(private_get_unused_directories "$PROJ_FOLDER/$PROJ_NAME")
    done
}

choose_project () {
    PROJ_NAME=$(find "$PROJ_FOLDER" -maxdepth 1 -type d |       # search the project foolder for directories
                sort |                                      # sort them
                tail -n +2 |                                # remove the '.' folder
                awk -F'/' '{print $(NF)}' |                 # only get the top's directory name
                dmenu -i -p "Choose Project: ")             # dmenu

    # Check if project name was given
    if [ "$PROJ_NAME" = "" ]; then
        return
    fi

    PROJ_FULL_NAME="$PROJ_NAME"
    while [ ! -f "$PROJ_FOLDER/$PROJ_FULL_NAME/.id" ]
    do
        PROJ_NAME=$(find "$PROJ_FOLDER/$PROJ_FULL_NAME" -maxdepth 1 -type d |
                    sort | tail -n +2 | awk -F'/' '{print $(NF)}' | dmenu -i -p "Choose Project: ")

        if [ $? = 0 ]; then
            PROJ_FULL_NAME="$PROJ_FULL_NAME/$PROJ_NAME"
        else # <ESC> -> Abort/Quit
            return
        fi
    done

    private_choose_project "$PROJ_FULL_NAME"
}

choose_all_projects () {
    PROJ_NAME=$(find "$GBT_PROJECTS" -maxdepth 4 -name ".id" |              # get folders with file '.id'
                sort |                                                      # sort them
                sed 's$'"$GBT_PROJECTS"/'$$g' |                             # get only the relative names from the base directory
                sed 's$/.id$$g' |                                           # remove the '/.id' file string
                dmenu -i -p "Choose Project: " -l 25)                       # dmenu

    [ "$PROJ_NAME" = "" ] && exit 0

    private_choose_project "$PROJ_NAME"
}

show_project () {
    PROJ_NAME=$1

    notify-send -t 1500 "Current working project" "'$PROJ_NAME'"
}

get_full_project () {
    PROJ_NAME=$(private_get_project)

    echo "$PROJ_FOLDER/$PROJ_NAME"
}

# PRIVATE FUNCTIONS
private_get_unused_directories () {
    existing_directories=$(find "$1" -maxdepth 1 -type d |                 # search directories in folder
                           tail -n +2 |                                    # remove '.' folder
                           awk -F'/' '{print $(NF)}' |                     # only get the directory name
                           sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/|/g')     # remove new lines from results and replace with '|'


    printf "Code\nRepos\nManuals\nDocumentation\nImages\nSchematics\nPictures\nOther" |
    sort |
    awk '{gsub(/'"$existing_directories"'/,"")}1' |
    sed '/^$/d' |
    dmenu -i -p "Input: "
}

private_choose_project () {
    # Check that given directory exists
    [ ! -d "$1" ] && notify -u critical -t 2500 "Error" "Given directory doesn't exist" && exit 1

    # Change current working project in the configs
    sed -i "s/proj=.*$/proj=$(echo "$1" | sed 's/\//\\\// g')/ g" "$SCRIPTS/.config/.gbt_project"

    # Create new simlink
    simlink_name="GBT_Project"
    rm "$PROJ_FOLDER/../$simlink_name"
    ln -s "$PROJ_FOLDER/$1" "$PROJ_FOLDER/../$simlink_name"

    show_project "$1"
}

private_get_project () {
    PROJ_NAME=$(grep -e "^proj=" "$SCRIPTS/.config/.gbt_project" | sed 's/proj=\s*// g')

    echo "$PROJ_NAME"
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
        --create-folders)
        shift # past argument
        create_folders
        exit 0
        ;;
        -c|--choose)
        shift # past argument
        choose_project
        exit 0
        ;;
        --choose-all)
        shift # past argument
        choose_all_projects
        exit 0
        ;;
        -s|--show)
        shift # past argument
        show_project "$(private_get_project)"
        exit 0
        ;;
        -g|--get)
        shift # past argument
        get_full_project
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
