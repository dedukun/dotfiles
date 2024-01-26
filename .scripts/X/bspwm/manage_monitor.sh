#!/bin/sh

save_file="$SCRIPTS/.cache/manage_monitor"

print_help() {
    printf "Manage Monitors in BSPWM\n"
    printf "This script organizes the desktop when a external monitor is connected/disconnected.\n"
    printf "\n"
    printf "\t-s, --save        Save the current windows positions to a file\n"
    printf "\t-l, --load        Load windows positions from file and apply them\n"
    printf "\t-h, --help        Prints help menu\n"
}

save() {
    array_json=""
    desktops="$(bspc query -D)"
    for d in $desktops; do
        # Don't add nodes that start with '0x004' (these seem to be group nodes)
        nodes="$(bspc query -N -d $d | grep -v '0x004')"
        if [ "$nodes" != "" ]; then
            json=$(jq -n \
                --arg d "$d" \
                --arg nodes "$nodes" \
                '{ $d, nodes: $nodes | split("\n") }')
            if [ -z "$array_json" ]; then
                # if first json, open the array and append the json
                array_json="["$json
            else
                array_json=$array_json,$json
            fi
        fi
    done
    # close the array
    array_json=$array_json"]"

    jq -n \
        --argjson array "$array_json" \
        '{desktops: $array  }' > $save_file
}

load() {
    if [ ! -f "$save_file" ]; then
        echo "Save File doesn't exist"
        exit 1
    fi

    for row in $(jq -c '.[][]' $save_file); do
        desktop=$(echo "$row" | jq '.d')
        nodes=$(echo "$row" | jq '.nodes')
        for node in $(echo "$row" | jq -c '.nodes[]'); do
            bspc node "$node" --to-desktop "$desktop"
        done
    done
}

while [[ $# -gt 0 ]]; do
    mm_key="$1"

    case $mm_key in
        -s | --save)
            save
            shift # past argument
            ;;
        -l | --load)
            load
            shift # past argument
            ;;
        *)
            echo "Invalid argument '$1'."
            echo "For more help use argument -h or --help".
            shift # past argument
            exit 1
            ;;
    esac
done
