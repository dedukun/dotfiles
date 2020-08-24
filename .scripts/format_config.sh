#!/bin/sh

format_config_path="$HOME/.config/formatconfig"

if [ ! -z "$(fd --type f --extension c)" ]; then
    notify-send -t 2000 "Format Config" "Formatting for C Project"
    cp $format_config_path/clang-format-template .clang-format
else
    notify-send -u critical -t 2000 "Format Config" "No supported project detected"
fi
