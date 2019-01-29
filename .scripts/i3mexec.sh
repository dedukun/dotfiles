#!/bin/bash
# i3 Mark exec
print_help () {
    echo "i3 Mark Exec"
    echo "This script executes a command on a marked window (with i3 marks)"
    echo -e "\t-c, --command   Change command to execute"
    echo -e "\t-s, --show      Show current command"
    echo -e "\t-h, --help      Prints help menu"
}

change_command () {
    commands=$(ls mexec/*)
    selected=$(echo "$commands" | dmenu -p "Select command:")

    if [[ ! -f $selected ]]; then
        notify-send -t 1000 "Creating new command '$selected'"
        selected="mexec/$selected"
        vim "$selected"
    fi
    rm mexec/.C_* 2> /dev/null
    cp "$selected" "mexec/.C_$(basename "$selected")"

    notify-send -t 1000 "Selected '$selected'"
}

show_command () {
    command=$(ls mexec/.C_* 2> /dev/null)

    if [[ -n $command ]]; then
        command=$(echo "$command" | cut -d'_' -f 2) # remove prefix
        notify-send -t 2000 "The current command is\n$command"
    else
        notify-send -t 2000 "No command selected\nUse i3mexec -c to select a command"
    fi
}

# cd to .scripts folder because of i3 call
cd "$HOME/.scripts" || exit

while [[ $# -gt 0 ]]
do
    MEXEC_KEY="$1"

    case $MEXEC_KEY in
        -c|--command)
        change_command
        exit 0
        shift # past argument
        ;;
        -s|--show)
        show_command
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

command=$(ls mexec/.C_* 2> /dev/null)

if [[ ! -n $command ]]; then
    notify-send -t 2000 "No command selected\nUse i3mexec -c to select a command"
fi

i3-msg unmark mexecOri | grep supress # unmark previous call
i3-msg mark mexecOri | grep supress # mark current window
i3-msg [con_mark="mexecDest"] focus  | grep supress # focus destination window

/bin/bash $command

i3-msg [con_mark="mexecOri"] focus | grep supreess # return to original window
