#!/bin/bash
print_help() {
    printf "Change Second Monitor\n"
    printf "This wrapper script helps configuring the second display.\n"
    printf "\n"
    printf "\t-m, --mode        Specify the display mode (default 1920x1080)\n"
    printf "\t-M, --dmenu-mode  Choose the display mode using a dmenu list\n"
    printf "\t    --output      Specify the output (default HDMI2)\n"
    printf "\t-a, --above       Set second display above the main display\n"
    printf "\t-l, --left        Set second display to the left of the main display\n"
    printf "\t-r, --right       Set second display to the right of the main display\n"
    printf "\t-b, --below       Set second display below the main display\n"
    printf "\t-o, --off         Turn the second display off\n"
    printf "\t    --only        Only have the external display turn on\n"
    printf "\t-p, --primary     Set the external monitor as primary\n"
    printf "\t-h, --help        Prints help menu\n"
}

change_i3_workspace_outputs() {
    sed -i -r "s/(^workspace \"[1-4]\" output ).*/\1$1/" "$HOME/.config/i3/config"
    sed -i -r "s/(^workspace \"[5-7]\" output ).*/\1$2/" "$HOME/.config/i3/config"

    i3-msg -q reload
}

reset_bspwm() {
    if [ "$1" = "single" ]; then
        bspc monitor "$2" -d 1 2 3 4 5 6 7 8 9 10
    elif [ "$1" = "dual" ]; then
        bspc monitor "$2" -d 1 2 3 4
        bspc monitor "$3" -d 5 6 7 8 9 10
        bspc wm -O "$2" "$3"
    fi
}

reset_polybar() {
    if [ "$1" = "single" ]; then
        killall -q polybar
        nohup polybar default >/dev/null 2>&1 &
    elif [ "$1" = "dual" ]; then
        killall -q polybar
        nohup polybar primary >/dev/null 2>&1 &
        nohup polybar second >/dev/null 2>&1 &
    fi
}

single_monitor() {
    if [ "$3" = "" ]; then
        xrandr --output "$1" --off --output "$2" --auto --primary
    else
        xrandr --output "$1" --off --output "$2" --mode "$3" --primary
    fi

    reset_bspwm "single" "$2"
    reset_polybar "single" "$2"
}

# Use dmenu to choose display mode
dmenu_mode() {
    output_list="$($SCRIPTS/xrandr-query.sh "$dis_out" | tail -n +2 | awk '{print $1;}')"
    dis_mode=$(echo "$output_list" | rofi -dmenu -p "Display Mode: ")
}

dis_mode="1920x1080"
dis_out="HDMI2"
dis_base_monitor="eDP1"
dis_direction=""

while [[ $# -gt 0 ]]; do
    dis_key="$1"

    case $dis_key in
        -m | --mode)
            dis_mode="$2"
            shift # past value
            shift # past argument
            ;;
        -M | --dmenu-mode)
            dmenu_mode
            shift # past argument
            exit
            ;;
        --output)
            dis_out="$2"
            shift # past value
            shift # past argument
            ;;
        -a | --above)
            dis_direction="--above"
            shift # past value
            ;;
        -l | --left)
            dis_direction="--left-of"
            shift # past value
            ;;
        -r | --right)
            dis_direction="--right-of"
            shift # past value
            ;;
        -b | --below)
            dis_direction="--below"
            shift # past value
            ;;
        -o | --off)
            single_monitor "$dis_out" "$dis_base_monitor"
            shift # past value
            exit
            ;;
        --only)
            single_monitor "$dis_base_monitor" "$dis_out"
            shift # past value
            exit
            ;;
        -p | --primary)
            dis_primary="yes"
            shift # past value
            ;;
        -h | --help)
            shift # past argument
            print_help
            exit
            ;;
        *)
            echo "Invalid argument '$1'."
            echo "For more help use argument -h or --help".
            shift # past argument
            exit 1
            ;;
    esac
done

if [[ -n $dis_primary ]]; then # Set secondary monitor with primary option
    xrandr --output "$dis_out" --mode "$dis_mode" $dis_direction "$dis_base_monitor" --primary

    reset_bspwm "dual" "$dis_base_monitor" "$dis_out"
    reset_polybar "dual"
else # Set secondary monitor
    xrandr --output "$dis_out" --mode "$dis_mode" $dis_direction "$dis_base_monitor"

    reset_bspwm "dual" "$dis_base_monitor" "$dis_out"
    reset_polybar "dual"
fi
