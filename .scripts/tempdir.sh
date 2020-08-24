#!/bin/bash
# Creates a temporary directory for testing stuff

mtd_suffix="-mtd"
mtd_cache="$SCRIPTS/.cache/mtd"

_exit_error() {
    echo "$1"
    echo "For more help use argument -h or --help".
    exit 1
}

print_help() {
    printf "Make Temporary Directory\n"
    printf "Creates and Manages Temporary directories."
    printf "\n"
    printf "\t-g , --get            Creates temporary directory and prints name to terminal\n"
    printf "\t-gc, --get-cached     Get the name of one of the cached directories\n"
    printf "\t-s , --select         Opens a dmenu to choose whether to create new directory, or use an cached directory\n"
    printf "\t-l , --list-cache     Prints directories cache to terminal\n"
    printf "\t-d , --delete         Deletes Temporary directories\n"
    printf "\t-dc, --delete-current Deletes mtd directory if directory is in current path\n"
    printf "\t-cc, --clean-cache    Checks if directories in cache still exists and removes then from cache if don't\n"
    printf "\t-h , --help           Prints help menu\n"
}

_remove_from_cache() {
    mtd_dir=$(echo $1 | grep -E "/tmp/tmp\.[a-zA-Z0-9]{10}-mtd")
    [ ! "$mtd_dir" ] && _exit_error "Error - Tried to remove non-mtd directory '$1'."

    sed -i "\#$1#d" "$mtd_cache"
}

rm_directory() {
    _remove_from_cache $1

    printf "   $1\n"
    rm -rf "$1"
}

delete_directories() {
    [ ! -f "$mtd_cache" ] && _exit_error "No directories in cache"

    # if [ $(id -u) -eq 0 ]; then
    #     echo "Running deletions as root is not accepted"
    #     exit 0
    # fi

    # [WIP]
    # if [ $(id -u) -eq 0 ]; then
    #     echo "Running deletions as root is not recommended."
    #     printf "Do you want to delete it either way? [Y/n] "
    #     if read -q; then
    #         printf "Removing $mtd_dir... "
    #         rm_directory "$tmp_dir"
    #     fi
    #     echo
    #     exit 1
    # fi

    printf "Deleting directories...\n"

    while read tmp_dir <&3; do
        # make sure its only auto deleting intended directories
        if [ $(echo "$tmp_dir" | grep -e "^/tmp/tmp\..*$mtd_suffix") ]; then
            rm_directory "$tmp_dir"
        else
            echo "Directory '$tmp_dir' does not have the right format."
            printf "Do you want to delete it either way? [Y/n] "
            if read -q; then
                rm_directory "$tmp_dir"
            fi
            echo
        fi
    done 3<"$mtd_cache"

    rm $mtd_cache
    printf "Done\n"
}

delete_current_directory() {
    mtd_dir=$(echo $PWD | grep -E "/tmp/tmp\.[a-zA-Z0-9]{10}-mtd" | sed -r 's/^(\/tmp\/tmp\.[a-zA-Z0-9]{10}-mtd).*$/\1/')
    [ ! "$mtd_dir" ] && _exit_error "Not a valid mtd directory."

    if [ $(id -u) -eq 0 ]; then
        echo "Running deletions as root is not recommended."
        printf "Do you want to delete it either way? [Y/n] "
        if read -q; then
            printf "Removing $mtd_dir... "
            rm_directory "$tmp_dir"
            echo
        else
            exit 1
        fi
    fi

    printf "Removing $mtd_dir... "
    rm_directory "$mtd_dir"
    echo "done"
}

create_directory() {
    dir_name=$(mktemp -d --suffix="$mtd_suffix")
    echo "$dir_name" >>"$mtd_cache"
    echo "$dir_name"
}

get_cached_directory() {
    number_of_lines="$(cat $mtd_cache | wc -l)"

    if [ "$number_of_lines" -gt 25 ]; then
        number_of_lines=25
    fi

    dir_name="$(cat $mtd_cache | rofi -dmenu -p 'Select cached directory' -l $number_of_lines)"
    echo "$dir_name"
}

select_directory() {
    choice="$(printf 'Create new temporary directory\nChoose from cached directories' | rofi -dmenu -l 2)"

    case "$choice" in
        "Create new temporary directory")
            create_directory
            ;;

        "Choose from cached directories")
            get_cached_directory
            ;;
    esac
}

show_cache() {
    [ ! -f "$mtd_cache" ] && echo "No directories in cache" && exit
    echo "Directories in cache:"
    cat "$mtd_cache"
}

check_cached_directories() {
    [ ! -f "$mtd_cache" ] && echo "No directories in cache" && exit

    printf "Cleaning cache... "
    while read tmp_dir <&3; do
        [ ! -d "$tmp_dir" ] && _remove_from_cache "$tmp_dir"
    done 3<"$mtd_cache"

    printf "done\n"
}

[ $# -eq 0 ] && _exit_error "Error: No argument"

while [ $# -gt 0 ]; do
    mtd_key="$1"

    case $mtd_key in
        -g | --get)
            shift # past argument
            create_directory
            ;;
        -gc | --get-cached)
            shift # past argument
            get_cached_directory
            exit
            ;;
        -s | --select)
            shift # past argument
            select_directory
            exit
            ;;
        -l | --list-cache)
            shift # past argument
            check_cached_directories
            show_cache
            exit
            ;;
        -d | --delete)
            shift # past argument
            delete_directories
            exit
            ;;
        -dc | --delete-current)
            shift # past argument
            delete_current_directory
            exit
            ;;
        -c | --check)
            shift # past argument
            check_cached_directories
            exit
            ;;
        -h | --help)
            shift # past argument
            print_help
            exit
            ;;
        *)
            shift # past argument
            _exit_error "Invalid argument '$mtd_key'."
            ;;
    esac
done
