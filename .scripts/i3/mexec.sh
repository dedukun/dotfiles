#!/bin/sh
# i3 Mark exec
print_help () {
    echo "i3 Mark Exec"
    echo "This script executes a bash script on a marked window (using i3 marks)"
    printf "\t-c, --command   Change script to execute\n"
    printf "\t-s, --show      Show selected script\n"
    printf "\t-h, --help      Prints help menu\n"
}

change_script () {
    scripts=$(ls mexec/* 2> /dev/null)
    selected=$(echo "$scripts" | dmenu -i -p "Select script:")

    if [ ! -f "$selected" ]; then
        # Test if the given st is installed
        [ ! -n "$(command -v "st")" ] \
            && notify-send -u critical -t 4000 "'st' is not installed in your system." \
                                                "You cant create new scripts ." && exit 1

        notify-send -t 1000 "Creating new script '$selected'"
        selected="mexec/$selected"
        st vim "$selected"

        [ ! -f "$selected" ] && notify-send -u critical -t 1500 "'$selected' wasn't created." && exit 1
    fi

    rm mexec/.C_* 2> /dev/null # delete old selection
    cp "$selected" "mexec/.C_$(basename "$selected")" # create new selection

    notify-send -t 1000 "Selected '$selected'"
}

show_script () {
    script=$(ls mexec/.C_* 2> /dev/null)

    if [ -n "$script" ]; then
        script=$(echo "$script" | cut -d'_' -f 2) # remove prefix
        notify-send -t 2000 "The current script is" "$script"
    else
        notify-send -t 2000 "No script selected" "Use i3mexec -c to select a script"
    fi
}

# check if a script is alredy running using mexec
[ "$(pgrep mexec.sh | wc -l)" -ge "3" ] && (notify-send -u critical -t 1000 "Already running a script\n") && exit 1

# cd to .scripts/i3 folder so that working dir is always the same
cd "$SCRIPTS/i3" || exit 1

while [ $# -gt 0 ]
do
    MEXEC_KEY="$1"

    case $MEXEC_KEY in
        -c|--command)
        change_script
        exit 0
        shift # past argument
        ;;
        -s|--show)
        show_script
        exit 0
        shift # past argument
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

script=$(ls mexec/.C_* 2> /dev/null)

if [ ! -n "$script" ]; then
    notify-send -t 2000 "No script selected" "Use i3mexec -c to select a script"
    exit 1
fi

i3-msg -q mark mexecOri # mark current window
i3-msg -q [con_mark="mexecDest"] focus  # move to window

/bin/bash "$script"

i3-msg -q [con_mark="mexecOri"] focus # return to original window
i3-msg -q unmark mexecOri # unmark 'mexecOri'
