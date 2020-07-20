#!/bin/sh
#
# Write/remove a task to do later.
#
# Select an existing entry to remove it from the file, or type a new entry to
# add it.
#
# original:https://tools.suckless.org/dmenu/scripts/todo

notify_send_flags='--replaces-process "todo-list"'
todo_file="$SCRIPTS/.cache/.todo"

print_help () {
    echo "TODO list."
    echo "Calling it with no arguments will start the default todo list."
    printf "\t -l, --list         Specify the list to use\n"
    printf "\t -h, --help         Prints this help menu\n"
}

# https://stackoverflow.com/questions/15783701/which-characters-need-to-be-escaped-when-using-bash/20053121#20053121
escape_input () {
    echo "$1" | sed -e 's/[^a-zA-Z0-9,._+?@%/()><-]/\\&/g; 1{$s/^$/""/}; 1!s/^/"/; $!s/$/"/'
}

while [ $# -gt 0 ]
do
    todo_key="$1"

    case $todo_key in
        -l|--list)
            todo_file="$2"
            shift # past argument
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

#[ -d "$todo_file" ] && notify-send.py  --urgency=critical -t 2000 "ERROR" "'$todo_file' is a directory" $notify_send_flags && exit 1
[ -d "$todo_file" ] && notify-send  --urgency=critical -t 2000 "ERROR" "'$todo_file' is a directory" && exit 1

#[ ! -f "$todo_file" ] && notify-send.py  -t 2000 "New Todo List" "New list was created at '$todo_file'"  $notify_send_flags
[ ! -f "$todo_file" ] && notify-send  -t 2000 "New Todo List" "New list was created at '$todo_file'"

touch "$todo_file"
height=$(wc -l "$todo_file" | awk '{print $1}')
prompt="Add/delete a task"

cmd=$(sort "$todo_file" | rofi -dmenu -l "$height" -p "$prompt")
while [ -n "$cmd" ]; do
    escaped_cmd=$(escape_input "$cmd")
    if grep -q "^$escaped_cmd\$" "$todo_file"; then
        tmpfile=$(mktemp)
        grep -v "^$escaped_cmd\$" "$todo_file" > "$tmpfile"
        mv "$tmpfile" "$todo_file"
        height=$(( height - 1 ))
    else
        echo "$cmd" >> "$todo_file"
        height=$(( height + 1 ))
    fi

    cmd=$(sort "$todo_file" | rofi -dmenu -l "$height" -p "$prompt")
done
