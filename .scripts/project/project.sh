#!/bin/sh
# Manages GBT projects.

config_file=""
proj_folder=""
symlink=""

print_help () {
    echo "This script helps creating a project and manage it."
    printf "Usage '%s'\n" "$(basename "$0")"
    printf "\t-n, --new            Create a new project\n"
    printf "\t    --create-folders Create folders for current working project\n"
    printf "\t-c, --choose         Choose the current working project from all\n"
    printf "\t-s, --show           Show the current project\n"
    printf "\t-g, --get            Get the full path to the current working project\n"
    printf "\t  , --config         Pass a custom configuration file\n"
    printf "\t  , --folder         Pass a custom projects folder\n"
    printf "\t  , --symlink        Pass a custom sym link name\n"
    printf "\t-h, --help           Prints help menu\n"
}

new_project () {
    proj_name=$(echo | rofi -dmenu -p "Project Name")

    [ "$proj_name" = "" ] && exit 0

    [ -d "$proj_folder/$proj_name" ] && notify-send -u critical -t 1500 "Project '$proj_name' already exists!" && exit 1

    mkdir -p "$proj_folder/$proj_name"

    proj_id=$(grep -e "^id=" "$config_file" | sed 's/id=\s*// g')
    echo "$proj_id" > "$proj_folder/$proj_name/.id"
    sed -i "s/id=.*$/id=$((proj_id+1))/ g" "$config_file"

    create_folders "$proj_name"
}

create_folders () {
    if [ -n "$1" ]; then
        proj_name="$1"
    else
        proj_name=$(_get_project)
    fi

    proj_input=$(_get_unused_directories "$proj_name")
    while true ; do
        if [ "$proj_input" = "" ]; then
            break
        elif [ "$proj_input" = "Second" ]; then
            _link_second "$proj_name"
        fi

        mkdir "$proj_name/$proj_input"
        proj_input=$(_get_unused_directories "$proj_name")
    done
}

choose_project () {
    proj_name=$(find "$proj_folder" -maxdepth 4 -name ".id" |        # get folders with file '.id'
                sort |                                               # sort them
                sed 's$'"$proj_folder"/'$$g' |                       # get only the relative names from the base directory
                sed 's$/.id$$g' |                                    # remove the '/.id' file string
                rofi -dmenu -i -p "Choose Project" -l 25)            # dmenu

    [ "$proj_name" = "" ] && exit 0

    _choose_project "$proj_folder/$proj_name"
}

show_project () {
    proj_name=$1

    notify-send -t 1500 "Current working project" "'$proj_name'"
}

get_full_project () {
    proj_name=$(_get_project)

    echo "$proj_name"
}

# PRIVATE FUNCTIONS
_get_unused_directories () {
    existing_directories=$(find "$1" -maxdepth 1 -type d |                 # search directories in folder
                           tail -n +2 |                                    # remove '.' folder
                           awk -F'/' '{print $(NF)}' |                     # only get the directory name
                           sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/|/g')     # remove new lines from results and replace with '|'


    printf "Code\nRepos\nManuals\nDocumentation\nDocuments\nImages\nSchematics\nMedia\nPictures\nOther\nSecond" |
    sort |
    awk '{gsub(/'"$existing_directories"'/,"")}1' |
    sed '/^$/d' |
    rofi -dmenu -i -p "Input" -l 11
}

_choose_project () {
    # Check that given directory exists
    [ ! -d "$1" ] && notify-send -u critical -t 2500 "Error" "Given directory doesn't exist" && exit 1

    # Change current working project in the configs
    sed -i "s/proj=.*$/proj=$(echo "$1" | sed 's/\//\\\// g')/ g" "$config_file"

    # Create new simlink
    rm "$proj_folder/../$symlink"
    ln -s "$1" "$proj_folder/../$symlink"

    show_project "$1"
}

_get_project () {
    proj_name=$(grep -e "^proj=" "$config_file" | sed 's/proj=\s*// g')

    echo "$proj_name"
}

_link_second () {
    # check if second is mounted
    notify-send "IM LINKING SECOND" "$1"

}

while [ $# -gt 0 ]
do
    proj_key="$1"

    case $proj_key in
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
        -s|--show)
        shift # past argument
        show_project "$(_get_project)"
        exit 0
        ;;
        -g|--get)
        shift # past argument
        get_full_project
        exit 0
        ;;
        --config)
        config_file="$2"
        shift # past argument
        shift # past value
        ;;
        --folder)
        proj_folder="$2"
        shift # past argument
        shift # past value
        ;;
        --symlink)
        symlink="$2"
        shift # past argument
        shift # past value
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
