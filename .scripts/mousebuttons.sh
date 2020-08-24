#!/bin/sh
# Reassign extra mouse buttons

notify_send_flags='--replaces-process "mouse-buttons"'

print_help() {
    printf "Mouse Extra Buttons\n"
    printf "This script reassigns key presses to the mouse extra buttons.\n"
    printf "\t-b, --back      Back button press\n"
    printf "\t-f, --forward   Forward button press\n"
    printf "\t-m, --mode      Mode for extra functionality\n"
    printf "\t-t, --toggle    Toggle the application on/off\n"
    printf "\t-s, --show      Show current mode\n"
    printf "\t-h, --help      Prints help menu\n"
}

exit_error() {
    #notify-send.py  -t 1500 -u critical "ERROR" "$1" $notify_send_flags
    notify-send -t 1500 -u critical "ERROR" "$1"
    exit 1
}

toggle_app() {
    meb_mode=$(get_mode)
    if [ "$(pgrep xbindkeys)" = "" ]; then
        #notify-send.py -t 1500 -u normal "Toggle On" "'$meb_mode'" $notify_send_flags
        notify-send -t 1500 -u normal "Toggle On" "'$meb_mode'"
        xbindkeys
    else
        #notify-send.py -t 1500 -u normal "Toggle Off" $notify_send_flags
        notify-send -t 1500 -u normal "Toggle Off"
        killall xbindkeys
    fi
    exit 0
}

back_press() {
    meb_mode=$(get_mode)
    case $meb_mode in
        "LeftRight")
            xdotool key 113
            ;;
        "UpDown")
            xdotool key 116
            ;;
        "PagesUpDown")
            xdotool key --delay 2 Down Page_Up Down Up
            ;;
        "Workspace")
            i3-msg workspace prev
            ;;
        "Firefox Reader View")
            xdotool key Ctrl+Alt+r
            ;;
        "Firefox Force Reader View")
            xdotool key F6 Home
            xdotool type "about:reader?url="
            xdotool key Return
            ;;
        "Off")
            # DO NOTHING
            ;;
        "")
            # DO NOTHING
            ;;
        *)
            #notify-send.py  -u critical -t 1500 "Unkown gbt choice '$MAN_CMD'" $notify_send_flags
            notify-send -u critical -t 1500 "Unkown gbt choice '$MAN_CMD'"
            exit 1
            ;;
    esac
    exit 0
}

forward_press() {
    meb_mode=$(get_mode)
    case $meb_mode in
        "LeftRight")
            xdotool key 114
            ;;
        "UpDown")
            xdotool key 111
            ;;
        "PagesUpDown")
            xdotool key --delay 2 Up Page_Down Up Down
            ;;
        "Workspace")
            i3-msg workspace next
            ;;
        "Firefox Reader View")
            xdotool key --delay 2 Up Up Up Page_Down
            ;;
        "Firefox Force Reader View")
            xdotool key --delay 2 Up Up Up Page_Down
            ;;
        "Off")
            # DO NOTHING
            ;;
        "")
            # DO NOTHING
            ;;
        *)
            #notify-send.py  -u critical -t 1500 "Unkown gbt choice '$MAN_CMD'" $notify_send_flags
            notify-send -u critical -t 1500 "Unkown gbt choice '$MAN_CMD'"
            exit 1
            ;;
    esac
    exit 0
}

mode_select() {
    meb_mode=$(printf "LeftRight\nUpDown\nPagesUpDown\nWorkspace\nFirefox Reader View\nFirefox Force Reader View\nOff" | dmenu -i -p "Mode: ")
    sed -i "s/mode=.*$/mode=$meb_mode/ g" "$SCRIPTS/.config/.meb"

    # TODO MISSING CHECK VALUE
    show_mode
}

get_mode() {
    grep -e "^mode=" "$SCRIPTS/.config/.meb" | sed 's/mode=\s*// g'
}

show_mode() {
    meb_mode=$(get_mode)

    #notify-send.py  -u normal -t 1500 "[MEB] Current mode is" "'$meb_mode'" $notify_send_flags
    notify-send -u normal -t 1500 "[MEB] Current mode is" "'$meb_mode'"
}

[ $# -eq 0 ] && exit_error "Missing argument"

while [ $# -gt 0 ]; do
    meb_key="$1"

    case $meb_key in
        -b | --back)
            back_press
            shift # past value
            ;;
        -f | --forward)
            forward_press
            shift # past value
            ;;
        -m | --mode)
            mode_select
            shift # past argument
            ;;
        -t | --toggle)
            toggle_app
            shift # past argument
            ;;
        -s | --show)
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
