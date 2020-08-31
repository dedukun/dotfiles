#!/bin/sh

format_config_path="$HOME/.config/formatconfig"
formatted=""

if [ ! -z "$(fd --max-depth 2 --type f --extension c)" ]; then
    notify-send -t 2000 "Format Config" "Formatting for C Project"
    cp $format_config_path/clang-format-template .clang-format
    formatted="Y"
fi

if [ ! -z "$(fd --max-depth 2 --type f --extension js)" ]; then
    notify-send -t 2000 "Format Config" "Formatting for JS Project"
    cp $format_config_path/prettierrc-template .prettierrc
    formatted="Y"
fi


[ -z "$formatted" ]  && notify-send -u critical -t 2000 "Format Config" "No supported project detected"
