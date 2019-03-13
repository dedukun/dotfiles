#!/bin/bash
print_help () {
    echo -e "Change Second Monitor"
    echo -e "This script helps configuring the second display.\nWith no extra options the second monitor will be configured as a mirror of the main monitor."
    echo -e "\t-m, --mode        Specify the display mode (default 1920x1080)"
    echo -e "\t-M, --dmenu-mode  Choose the display mode using a dmenu list"
    echo -e "\t    --output      Specify the output (default HDMI2)"
    echo -e "\t-a, --above       Set second display above the main display"
    echo -e "\t-l, --left        Set second display to the left of the main display"
    echo -e "\t-r, --right       Set second display to the right of the main display"
    echo -e "\t-b, --below       Set second display below the main display"
    echo -e "\t-o, --off         Turn the second display off"
    echo -e "\t-p, --primary     Set the external monitor as primary"
    echo -e "\t-h, --help        Prints help menu"
}

change_workspace_outputs() {
    sed -i -r "s/(^workspace \"[1-4]\" output ).*/\1$1/"  "$HOME/.config/i3/config"
    sed -i -r "s/(^workspace \"[5-7]\" output ).*/\1$2/" "$HOME/.config/i3/config"

    i3-msg -q reload
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
        DIS_DMENU_MODE="yes"
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
        DIS_OFF="yes"
        shift # past value
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

# Set display off
if [[ -n $DIS_OFF ]]; then
    # Restore default workspaces configs
    change_workspace_outputs "$DIS_BASE_MONITOR" "$DIS_OUT"

    xrandr --output "$DIS_OUT" --off
    exit 0
fi

# Use dmenu to choose display mode
if [[ -n $DIS_DMENU_MODE ]]; then
    dis_list=$(xrandr)
    tail_line_number=$(echo "$dis_list"  | grep -n -e "^$DIS_OUT" |  cut -d ":" -f 1)
    dis_list=$(echo "$dis_list" |tail -n +$((tail_line_number + 1)))
    head_line_number=$(echo "$dis_list" | grep -n -e "^[a-zA-Z0-9]" | head -n 1 | cut -d ":" -f 1)

    lines=$(echo "$dis_list" | wc -l)
    head_line_number=$(("$head_line_number"-1))
    dis_list=$(echo "$dis_list" | head -n -$(( "$lines" - "$head_line_number" )) | awk '{print $1}')

    DIS_MODE=$(echo "$dis_list" | dmenu -p "Display Mode: " -l 20)
fi

# Set secondary monitor with primary option
if [[ -n $DIS_PRIMARY ]]; then
    change_workspace_outputs "$DIS_OUT" "$DIS_BASE_MONITOR"

    xrandr --output "$DIS_OUT" --mode "$DIS_MODE" $DIS_DIRECTION "$DIS_BASE_MONITOR" --primary
# Set secondary monitor
else
    change_workspace_outputs "$DIS_BASE_MONITOR" "$DIS_OUT"

    xrandr --output "$DIS_OUT" --mode "$DIS_MODE" $DIS_DIRECTION "$DIS_BASE_MONITOR"
fi
