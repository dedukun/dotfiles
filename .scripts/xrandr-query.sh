#!/bin/sh
# This script helps query a single output with xrandr

exit_error() {
    printf "ERROR %s\n" "$1" >&2;
    exit 1
}

[ "$1" = "" ] && exit_error "Need an output to query"

full_output="$(xrandr)"

[ "$( echo "$full_output" | grep -e "^$1\s")" = "" ] && echo "Given output '$1' doesn't exist"

# get the line number of when the desired output starts
line_number=$( echo "$full_output" | grep -n -e "^$1\s" | cut -d ":" -f 1)

# tail the full xrandr output to get only the starting from the desired display
semi_parsed_ouptut=$(echo "$full_output" | tail -n +"$line_number")

# get the line number of the display which appears next to the desired display
line_number=$(echo "$semi_parsed_ouptut" | grep -n -v "^\s" | head -n 2 | tail -n 1 | cut -d ":" -f 1)

echo "$semi_parsed_ouptut" | head -n $(( line_number - 1))
