#!/bin/sh
# Get the name of the primary and, if in use, the secondary display.

_exit_error() {
    printf "ERROR: %s\n" "$1" >&2
    echo "For more help use argument -h or --help".
    exit 1
}

print_help() {
    printf "Optimus Manager Wrapper\n"
    printf "This wrapper script fixes scripts and configurations that use the displays.\n"
    printf "\n"
    printf "\t-e , --eDP     Print the eDP display name\n"
    printf "\t   , --HDMI    Print the eDP display name\n"
    printf "\t-b , --both    Print both the eDP and HDMI display names\n"
    printf "\t-h , --help    Prints help menu\n"
}

get_eDP() {
    xrandr | grep "connected" | grep "eDP" | awk '{ print $1; }'
}

get_HDMI() {
    xrandr | grep "connected" | grep "HDMI" | awk '{ print $1; }'
}

get_both() {
    echo "$(get_eDP) $(get_HDMI2)"
}

while [ $# -gt 0 ]; do
    get_display_names_key="$1"

    case $get_display_names_key in
        -e | --eDP)
            get_eDP
            shift # past argument
            ;;
        --HDMI)
            get_HDMI
            shift # past argument
            ;;
        -b | --both)
            get_both
            shift # past argument
            ;;
        -h | --help)
            shift # past argument
            print_help
            exit
            ;;
        *)
            _exit_error "Invalid argument '$1'."
            ;;
    esac
done
