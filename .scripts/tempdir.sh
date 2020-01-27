#!/bin/bash
# Creates a temporary directory for testing stuff

mtd_suffix="-mtd"
mtd_cache="$SCRIPTS/.cache/mtd"

exit_error() {
    echo "$1"
    echo "For more help use argument -h or --help".
    exit 1
}

print_help() {
    printf "Make Temporary Directory\n"
    printf "Creates and Manages Temporary directories."
    printf "\n"
    printf "\t-g, --get         Creates temporary directory and prints name to terminal\n"
    printf "\t-l, --list-cache  Prints directories cache to terminal\n"
    printf "\t-d, --delete      Deletes Temporary directories\n"
    printf "\t-h, --help        Prints help menu\n"
}

rm_directory() {
    printf "   $1\n"
    sed -i "\#$1#d" "$mtd_cache"
    rm -rf "$1"
}

delete_directories() {
    [ ! -f "$mtd_cache" ] && exit_error "No directories in cache"

    printf "Deleting directories...\n"

    while read tmp_dir <&3; do
        # make sure its only auto deleting intended directories
        if [ $(echo "$tmp_dir" | grep -e "^/tmp/tmp\..*$mtd_suffix") ]; then
            rm_directory "$tmp_dir"
        else
            echo "Directory '$tmp_dir' does not have the right format."
            read -r -p "Do you want to delete it either way? [Y/n] " force_delete
            if [[ "$force_delete" =~ ^[Yy]?$ ]]; then
                rm_directory "$tmp_dir"
            fi
        fi
    done 3<"$mtd_cache"

    rm $mtd_cache
    printf "Done\n"
}

create_directory() {
    dir_name=$(mktemp -d --suffix="$mtd_suffix")
    echo "$dir_name" >>"$mtd_cache"
    echo "$dir_name"
}

show_cache() {
    [ ! -f "$mtd_cache" ] && echo "No directories in cache" && exit
    echo "Directories in cache:"
    cat "$mtd_cache"
}

[ $# -eq 0 ] && exit_error "Error: No argument"

while [ $# -gt 0 ]; do
    mtd_key="$1"

    case $mtd_key in
    -g | --get)
        shift # past argument
        create_directory
        ;;
    -l | --list-cache)
        shift # past argument
        show_cache
        exit
        ;;
    -d | --delete)
        shift # past argument
        delete_directories
        exit
        ;;
    -h | --help)
        shift # past argument
        print_help
        exit
        ;;
    *)
        shift # past argument
        exit_error "Invalid argument '$mtd_key'."
        ;;
    esac
done
