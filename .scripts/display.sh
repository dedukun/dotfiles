#!/bin/bash
print_help () {
    printf "Change Second Monitor\n"
    printf "This wrapper script helps configuring the second display."
    # printf "With no extra options the second monitor will be configured as a mirror of the main monitor."
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

change_workspace_outputs() {
    sed -i -r "s/(^workspace \"[1-4]\" output ).*/\1$1/"  "$HOME/.config/i3/config"
    sed -i -r "s/(^workspace \"[5-7]\" output ).*/\1$2/" "$HOME/.config/i3/config"

    i3-msg -q reload
}

# [ WIP ]
check_main_monitor() {
    xrandr | grep -A 1 "eDP1" | tail -n 1 | awk '{print $2}'
}

# Set display off
monitor_off () {
    # Restore default workspaces configs
    # change_workspace_outputs "$DIS_BASE_MONITOR" "$DIS_OUT"

    xrandr --output "$DIS_OUT" --off
    xrandr --output "$DIS_BASE_MONITOR" --mode 1366x768 --primary

    # ps aux | grep "polybar second"  | head -n 1  | awk '{print $2;}' | xargs kill -9
    bspc monitor $DIS_BASE_MONITOR -d 1 2 3 4 5 6 7 8 9 10
    killall -q polybar
    polybar default & > /dev/null
    exit 0
}

# Use dmenu to choose display mode
dmenu_mode () {
    dis_list=$(xrandr)
    tail_line_number=$(echo "$dis_list"  | grep -n -e "^$DIS_OUT" |  cut -d ":" -f 1)
    dis_list=$(echo "$dis_list" |tail -n +$((tail_line_number + 1)))
    head_line_number=$(echo "$dis_list" | grep -n -e "^[a-zA-Z0-9]" | head -n 1 | cut -d ":" -f 1)

    lines=$(echo "$dis_list" | wc -l)
    head_line_number=$(("$head_line_number"-1))
    dis_list=$(echo "$dis_list" | head -n -$(( "$lines" - "$head_line_number" )) | awk '{print $1}')

    DIS_MODE=$(echo "$dis_list" | dmenu -p "Display Mode: " -l 20)
}

# Only use the external monitor
only_external () {
    xrandr --output "eDP1" --off
    xrandr --output "$DIS_OUT" --mode "$DIS_MODE"

    killall -q polybar
    polybar second & > /dev/null
    bspc monitor $DIS_OUT -d 1 2 3 4 5 6 7 8 9 10
}

DIS_MODE="1920x1080"
DIS_OUT="HDMI2"
DIS_BASE_MONITOR="eDP1"
DIS_DIRECTION=""

while [[ $# -gt 0 ]]
do
    DIS_KEY="$1"

    case $DIS_KEY in
        -m|--mode)
            DIS_MODE="$2"
            shift # past value
            shift # past argument
            ;;
        -M|--dmenu-mode)
            dmenu_mode
            shift # past argument
            ;;
        --output)
            DIS_OUT="$2"
            shift # past value
            shift # past argument
            ;;
        -a|--above)
            DIS_DIRECTION="--above"
            shift # past value
            ;;
        -l|--left)
            DIS_DIRECTION="--left-of"
            shift # past value
            ;;
        -r|--right)
            DIS_DIRECTION="--right-of"
            shift # past value
            ;;
        -b|--below)
            DIS_DIRECTION="--below"
            shift # past value
            ;;
        -o|--off)
            monitor_off
            shift # past value
            ;;
        --only)
            only_external
            shift # past value
            exit 0
            ;;
        -p|--primary)
            DIS_PRIMARY="yes"
            shift # past value
            ;;
        -h|--help)
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

if [[ -n $DIS_PRIMARY ]]; then # Set secondary monitor with primary option
    # change_workspace_outputs "$DIS_OUT" "$DIS_BASE_MONITOR"

    xrandr --output "$DIS_OUT" --mode "$DIS_MODE" $DIS_DIRECTION "$DIS_BASE_MONITOR" --primary

    killall -q polybar

    bspc monitor $DIS_BASE_MONITOR -d 1 2 3 4
    bspc monitor $DIS_OUT -d 5 6 7 8 9 10
    bspc wm -O $DIS_BASE_MONITOR $DIS_OUT
    # if [ "$DIS_DIRECTION" = "--left-of" ]; then
    #     bspc monitor $DIS_OUT -g 1920x1080+0+0
    # else
    #     bspc monitor $DIS_OUT -g 1920x1080+1366+0
    # fi
    polybar primary & > /dev/null
    polybar second & > /dev/null
else # Set secondary monitor
    # change_workspace_outputs "$DIS_BASE_MONITOR" "$DIS_OUT"

    xrandr --output "$DIS_OUT" --mode "$DIS_MODE" $DIS_DIRECTION "$DIS_BASE_MONITOR"

    killall -q polybar

    bspc monitor $DIS_BASE_MONITOR -d 1 2 3 4
    bspc monitor $DIS_OUT -d 5 6 7 8 9 10
    bspc wm -O $DIS_BASE_MONITOR $DIS_OUT
    # if [ "$DIS_DIRECTION" = "--left-of" ]; then
    #     bspc monitor $DIS_OUT -g 1920x1080+0+0
    # else
    #     bspc monitor $DIS_OUT -g 1920x1080+1366+0
    # fi
    polybar primary & > /dev/null
    polybar second & > /dev/null
fi
