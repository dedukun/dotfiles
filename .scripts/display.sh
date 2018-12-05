#!/bin/bash
print_help () {
    echo -e "Change Second Monitor"
    echo -e "This script helps configuring the second display.\nWith no extra options the second monitor will be configured as a mirror of the main monitor."
    echo -e "\t-m, --mode     Specify the display mode (default 1920x1080)"
    echo -e "\t-a, --above    Set second display above the main display"
    echo -e "\t-l, --left     Set second display to the left of the main display"
    echo -e "\t-r, --right    Set second display to the right of the main display"
    echo -e "\t-b, --below    Set second display below the main display"
    echo -e "\t-o, --off      Turn the second display off"
    echo -e "\t-h, --help     Prints help menu"
}

DIS_MODE="1920x1080"

while [[ $# -gt 0 ]]
do
    DIS_KEY="$1"

    case $DIS_KEY in
        -m|--mode)
        DIS_MODE="$2"
        shift # past value
        shift # past argument
        ;;
        -a|--above)
        DIS_A="yes"
        shift # past value
        ;;
        -l|--left)
        DIS_L="yes"
        shift # past value
        ;;
        -r|--right)
        DIS_R="yes"
        shift # past value
        ;;
        -b|--below)
        DIS_B="yes"
        shift # past value
        ;;
        -o|--off)
        DIS_OFF="yes"
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

if [[ -n $DIS_OFF ]]; then
    xrandr --output HDMI2 --off
elif [[ -n $DIS_A ]]; then
    xrandr --output HDMI2 --mode $DIS_MODE --above eDP1
elif [[ -n $DIS_L ]]; then
    xrandr --output HDMI2 --mode $DIS_MODE --left-of eDP1
elif [[ -n $DIS_R ]]; then
    xrandr --output HDMI2 --mode $DIS_MODE --right-of eDP1
elif [[ -n $DIS_B ]]; then
    xrandr --output HDMI2 --mode $DIS_MODE --below eDP1
else
    xrandr --output HDMI2 --mode $DIS_MODE
fi
