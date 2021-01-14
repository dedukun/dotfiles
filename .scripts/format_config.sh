#!/bin/sh

format_config_path="$HOME/.config/formatconfig"
formatted=""

if [ -n "$(fd --max-depth 3 --type f --extension c --extension cpp --extension ino)" ]; then
    notify-send -t 2000 "Format Config" "Formatting for C/C++/Arduino Project"
    cp $format_config_path/clang-format-template .clang-format
    formatted="Y"
fi

if [ -n "$(fd --max-depth 3 --type f --extension js)" ]; then
    notify-send -t 2000 "Format Config" "Formatting for JS Project"
    cp $format_config_path/prettierrc-template .prettierrc
    formatted="Y"
fi


[ -z "$formatted" ]  && notify-send -u critical -t 2000 "Format Config" "No supported project detected"
