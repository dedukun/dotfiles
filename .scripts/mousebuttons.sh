#!/bin/sh
# Reassign extra mouse buttons

print_help () {
    printf "Mouse Extra Buttons\n"
    printf "This script reassigns key presses to the mouse extra buttons.\n"
    printf "\t-b, --back      Back button press\n"
    printf "\t-f, --forward   Forward button press\n"
    printf "\t-m, --mode      Mode for extra functionality\n"
    printf "\t-t, --toggle    Toggle the application on/off\n"
    printf "\t-s, --show      Show current mode\n"
    printf "\t-h, --help      Prints help menu\n"
}

error_exit() {
    notify-send -t 1500 -u critical "$1"
    exit 1
}

toggle_app() {
    meb_mode=$(get_mode)
    if [ "$(pgrep xbindkeys)" = "" ]; then
        notify-send -t 1500 -u normal "Toggle On" "'$meb_mode'"
        xbindkeys
    else
        notify-send -t 1500 -u normal "Toggle Off"
        killall xbindkeys
    fi
    exit 0
}

back_press() {
    # notify-send -t 1500 -u normal "Back"
    meb_mode=$(get_mode)
    case $meb_mode in
        "LeftRight")
            xdotool key 113
            ;;
        "UpDown")
            xdotool key 116
            ;;
        "Workspace")
            i3-msg workspace prev
            ;;
        "Off")
            ;;
        "")
            # DO NOTHING
            ;;
        *)
            notify-send -u critical -t 1500 "Unkown gbt choice '$MAN_CMD'"
            exit 1
            ;;
    esac
    exit 0
}

forward_press() {
    # notify-send -t 1500 -u normal "Forward"
    meb_mode=$(get_mode)
    case $meb_mode in
        "LeftRight")
            xdotool key 114
            ;;
        "UpDown")
            xdotool key 111
            ;;
        "Workspace")
            i3-msg workspace next
            ;;
        "Off")
            ;;
        "")
            # DO NOTHING
            ;;
        *)
            notify-send -u critical -t 1500 "Unkown gbt choice '$MAN_CMD'"
            exit 1
            ;;
    esac
    exit 0
}

mode_select() {
    meb_mode=$(printf "LeftRight\nUpDown\nWorkspace\nOff" | dmenu -i -p "Mode: ")
    sed -i "s/mode=.*$/mode=$meb_mode/ g" "$SCRIPTS/.config/.meb"

    # MISSING CHECK VALUE
    show_mode
}

get_mode() {
    grep -e "^mode=" "$SCRIPTS/.config/.meb" | sed 's/mode=\s*// g'
}

show_mode() {
    meb_mode=$(get_mode)

    notify-send -u normal -t 1500 "[MEB] Current mode is" "'$meb_mode'"
}

[ $# -eq 0 ] && error_exit "Error: Missing argument"

while [ $# -gt 0 ]
do
    meb_key="$1"

    case $meb_key in
        -b|--back)
        back_press
        shift # past value
        ;;
        -f|--forward)
        forward_press
        shift # past value
        ;;
        -m|--mode)
        mode_select
        shift # past argument
        ;;
        -t|--toggle)
        toggle_app
        shift # past argument
        ;;
        -s|--show)
        show_mode
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
