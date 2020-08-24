#!/bin/sh
# Multiple grep
# Grep multiple patters at the same time more easily.
# [WIP]

print_help() {
    echo "Multiple GREP."
    echo "Grep .. to make it easier to grep multiple patterns at the same time."
    echo "Usage: $0 [PARAMS] <patterns>..."
    printf "\t-h, --help            This help menu\n"
    printf "\t-i, --ignore-case     Do a case insensitive search\n"
    printf "\t-r, --recursive       Do a recursive search\n"
    printf "\t-R                    Same as '-r' but follows symbolic links\n"
}

search_params="--color=always "

while [ $# -gt 0 ]; do
    search_key="$1"

    case $search_key in
        -i | --ignore-case)
            shift # past argument
            search_params+="-i "
            ;;
        -r | --recursive)
            shift # past argument
            search_params+="-r "
            ;;
        -R)
            shift # past argument
            search_params+="-R "
            ;;
        -h | --help)
            shift # past argument
            print_help
            exit 0
            ;;
        -*)
            echo "Invalid argument '$1'."
            echo "For more information use argument -h or --help".
            shift # past argument
            exit 1
            ;;
        *)
            shift
            # Arguments
            ;;
    esac
done
