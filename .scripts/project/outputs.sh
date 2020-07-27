#!/bin/sh
#[WIP]
print_help () {
    echo "This script helps organizing commands outputs and kernel logs."
    printf "\t-h, --help      Prints help menu\n"
}

out_folder="$HOME/Globaltronic/Logging/outputs"
out_date_folder="$(date +%y_%m_%d)"

while [ $# -gt 0 ]
do
    out_key="$1"

    case $out_key in
        -h|--help)
        shift # past argument
        print_help
        exit
        ;;
        *)
        echo "Invalid argument '$1'."
        echo "For more information use argument -h or --help".
        shift # past argument
        exit 1
        ;;
    esac
done

# Create date's folder if it doesn't exists
if [ ! -d "$out_folder/$out_date_folder" ]; then
    mkdir  "$out_folder/$out_date_folder"
fi

# Get custom file name
out_name=$(echo | rofi -dmenu -p "File name")

# Add <time> to name
if [ ! -n "$out_name" ]; then
    out_name=$(date '+%H%M%S')
else
    out_name=$(date '+%H%M%S')_$out_name
fi

vim "$out_folder/$out_date_folder/$out_name"
