#!/bin/sh
print_help () {
    echo "This script helps organizing commands outputs and kernel logs."
    printf "\t-h, --help      Prints help menu\n"
}

OUT_FOLDER="$HOME/Globaltronic/Logging/outputs"
OUT_DATE_FOLDER="$(date +%y_%m_%d)"

while [ $# -gt 0 ]
do
    OUT_KEY="$1"

    case $OUT_KEY in
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
if [ ! -d "$OUT_FOLDER/$OUT_DATE_FOLDER" ]; then
    mkdir  "$OUT_FOLDER/$OUT_DATE_FOLDER"
fi

# Get custom file name
OUT_NAME=$(echo | dmenu -p "File name:")

# Add <time> to name
if [ ! -n "$OUT_NAME" ]; then
    OUT_NAME=$(date '+%H%M%S')
else
    OUT_NAME=$(date '+%H%M%S')_$OUT_NAME
fi

vim "$OUT_FOLDER/$OUT_DATE_FOLDER/$OUT_NAME"
