#!/bin/bash
print_help () {
    echo "This script helps to take and organize screenshots."
    echo "Calling it with no arguments will take a screenshot and save to the current date's folder."
    echo -e "\t -f, --folder       Specify the folder where the screenshots are saved (default: \$HOME/Pictures/screenshots)"
    echo -e "\t -s, --selected     Select the area of the screenshot"
    echo -e "\t -i, --window       Select window to take the screenshot"
    echo -e "\t-df, --date-folder  Save the screenshot in a subdirectory with the current date"
    echo -e "\t -t, --timer        Starts a countdown timer for the screenshot"
    echo -e "\t -m, --menu         Start the a menu to choose the type to screenshot to take"
    echo -e "\t -h, --help         Prints this help menu"
}

choose_menu () {
    screenshot_type=$(printf "Normal\nSelect\nWindow" | dmenu -i -p "Mode: ")

    case $screenshot_type in
        Normal)
            ;;
        Select)
            SCREEN_SELECTED=YES
            ;;
        Window)
            SCREEN_WINDOW=YES
            ;;
        *)
            echo "Invalid screenshot type '$1'."
            exit 1
            ;;
    esac
}

SCREEN_BASE_FOLDER="$HOME/Pictures/screenshots"
SCREEN_TMP_NAME="/tmp/_screenshotTMP.png"

while [[ $# -gt 0 ]]
do
    SCREEN_KEY="$1"

    case $SCREEN_KEY in
        -f|--folder)
            SCREEN_BASE_FOLDER=$2
            shift # past argument
            shift # past value
            ;;
        -s|--selected)
            SCREEN_SELECTED=YES
            shift # past argument
            ;;
        -i|--window)
            SCREEN_WINDOW=YES
            shift # past argument
            ;;
        -df|--date-folder)
            SCREEN_DATE_FOLDER=YES
            shift # past argument
            ;;
        -t|--timer)
            SCREEN_TIMER=$2
            shift # past argument
            shift # past value
            ;;
        -m|--menu)
            choose_menu
            shift # past value
            ;;
        -h|--help)
            shift # past argument
            print_help
            exit 0
            ;;
        *)
            echo "Invalid argument '$1'."
            echo "For more help use argument -h or --help."
            shift # past argument
            exit 1
            ;;
    esac
done

[ -f "$SCREEN_BASE_FOLDER" ] && notify-send -u critical -t 2000 "Not a directory" "'$SCREEN_BASE_FOLDER' is not a directory" && exit 1

# Check if the base folder exists
if [ ! -d "$SCREEN_BASE_FOLDER" ]; then
    mkdir -p "$SCREEN_BASE_FOLDER"
    notify-send -t 1500 "'$SCREEN_BASE_FOLDER' was created."
    printf "'%s' was created.\n" "$SCREEN_BASE_FOLDER"
fi

if [[ -n $SCREEN_TIMER ]]; then
    timer_count=0
    while [[ "$timer_count" != "$SCREEN_TIMER" ]]
    do
        timer_count=$((timer_count+1))
        notify-send -t 1000 "Timer: $((SCREEN_TIMER-timer_count))"
        sleep 1
    done
fi

# take the screen shot now so its timing doesn't depend on the user input
if [[ -n $SCREEN_SELECTED ]]; then
    maim -s --hidecursor "$SCREEN_TMP_NAME"
elif [[ -n $SCREEN_WINDOW ]]; then
    geometry=$(xwininfo | grep "geometry" | awk '{print $2;}')
    maim -g "$geometry" --hidecursor "$SCREEN_TMP_NAME"
else
    sleep 0.5
    maim --hidecursor "$SCREEN_TMP_NAME"
fi

# Set a custom file name (uses current date/time if no input)
SCREEN_NAME=$(echo | dmenu -p "Enter file name:")

# If a custom name is defined, add a "_" before it
if [ ! -z "$SCREEN_NAME" ]; then
    SCREEN_NAME="_"$SCREEN_NAME
fi

# Using a sub-directory with the date to save the screenshot
if [[ -n $SCREEN_DATE_FOLDER ]]; then

    SCREEN_DATE_FOLDER=$(date '+%F')

    # Create the folder if it doesn't exists
    if [ ! -d "$SCREEN_BASE_FOLDER/$SCREEN_DATE_FOLDER" ]; then
        mkdir "$SCREEN_BASE_FOLDER/$SCREEN_DATE_FOLDER"
    fi

    # Add the sub-directory to the pre-name
    SCREEN_PRE_NAME=$SCREEN_DATE_FOLDER/$(date '+%H%M%S')
else
    # Add date to pre-name
    SCREEN_PRE_NAME=$(date '+%F-%H%M%S')
fi

# move screen shot to the correct folder and rename it
if [[ -n $SCREEN_SELECTED ]]; then
    mv "$SCREEN_TMP_NAME" "$SCREEN_BASE_FOLDER/$SCREEN_PRE_NAME$SCREEN_NAME-S.png"; notify-send -t 2000 "Screenshot selected taken" "A new screenshot was saved to \'$SCREEN_BASE_FOLDER\'"
elif [[ -n $SCREEN_WINDOW ]]; then
    mv "$SCREEN_TMP_NAME" "$SCREEN_BASE_FOLDER/$SCREEN_PRE_NAME$SCREEN_NAME-W.png"; notify-send -t 2000 "Screenshot taken with ID" "A new screenshot was saved to \'$SCREEN_BASE_FOLDER\'"
else
    mv "$SCREEN_TMP_NAME" "$SCREEN_BASE_FOLDER/$SCREEN_PRE_NAME$SCREEN_NAME.png"; notify-send -t 2000 "Screenshot taken" "A new screenshot was saved to \'$SCREEN_BASE_FOLDER\'"
fi
