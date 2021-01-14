#!/bin/sh
# When switching between integrated and nvidia in optimus-manager, the display's name change in X.
# This script fixes this names in the configurations that are necessary.

_exit_error() {
    printf "ERROR: %s\n" "$1" >&2
    echo "For more help use argument -h or --help".
    exit 1
}

_change_polybar() {
    sed -i 's/${env:MONITOR:eDP.*}/${env:MONITOR:'$1'}/g' $HOME/.config/polybar/config
    sed -i 's/${env:MONITOR:HDMI.*}/${env:MONITOR:'$2'}/g' $HOME/.config/polybar/config
}

print_help() {
    printf "Optimus Manager Wrapper\n"
    printf "This wrapper script fixes scripts and configurations that use the displays.\n"
    printf "\n"
    printf "\t-f, --fix         Change the configurations to the current optimus-manager mode\n"
    printf "\t-h, --help        Prints help menu\n"
}

fix_configurations() {
    omw_eDP="$($SCRIPTS/auxiliar/get_display_names.sh -e)"
    omw_HMDI2="$($SCRIPTS/auxiliar/get_display_names.sh -h2)"

    _change_polybar "$omw_eDP" "$omw_HMDI2"
}

while [ $# -gt 0 ]; do
    omw_key="$1"

    case $omw_key in
        -f | --fix)
            fix_configurations
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
