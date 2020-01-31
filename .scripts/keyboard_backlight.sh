#!/bin/sh
# Control the keyboard backlight

kb_file="/sys/class/leds/asus::kbd_backlight/brightness"

print_help () {
    printf "Keyboard Backlight\n"
    printf "This script increases/decreases the keyboard backlight.\n"
    printf "\t-i, --inc   Increase the backlight brightness\n"
    printf "\t-d, --dec   Decrease the backlight brightness\n"
    printf "\t-h, --help  Prints help menu\n"
}

get_current_backlight() {
    cat "$kb_file"
}

set_backlight() {
    echo "$1" > "$kb_file"
}

inc_backlight() {
    cb=$(get_current_backlight)
    cb=$((cb+1))
    if [ "$cb" -gt 3 ];then
        cb=3
    fi

    set_backlight "$cb"
}

dec_backlight() {
    cb=$(get_current_backlight)
    cb=$((cb-1))
    if [ "$cb" -lt 0 ];then
        cb=0
    fi

    set_backlight "$cb"
}


[ $# -eq 0 ] && error_exit "Error: Missing argument"

while [ $# -gt 0 ]
do
    kb_key="$1"

    case $kb_key in
        -i|--inc)
            inc_backlight
            shift # past value
            ;;
        -d|--dec)
            dec_backlight
            shift # past value
            ;;
        -h|--help)
            print_help
            shift # past argument
            exit 0
            ;;
        *)
            echo "Invalid argument '$1'."
            echo "For more help use argument -h or --help".
            shift # past argument
            exit 1
            ;;
    esac
done
