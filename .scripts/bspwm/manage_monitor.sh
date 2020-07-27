#!/bin/sh
#[WIP]

print_help() {
    printf "Manage Monitors in BSPWM\n"
    printf "This script organizes the desktop when a external monitor is connected/disconnected.\n"
    printf "\n"
    printf "\t-s, --single      Specify the display mode (default 1920x1080)\n"
    printf "\t-h, --help        Prints help menu\n"
}

reset_monitor() {
    bspc monitor "$2" -d 1 2 3 4 5 6 7 8 9 10
}

while [[ $# -gt 0 ]]; do
    mm_key="$1"

    case $mm_key in
    -s | --single)
        shift # past argument
        ;;
    *)
        echo "Invalid argument '$1'."
        echo "For more help use argument -h or --help".
        shift # past argument
        exit 1
        ;;
    esac
done
