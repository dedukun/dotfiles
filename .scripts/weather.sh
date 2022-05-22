#!/bin/sh
# Simple wrapper for wttr.in
# Based on: https://www.reddit.com/r/bash/comments/9o2wap/favorite_bash_script_oneliner_or_utility

_exit_error() {
    printf "ERROR: %s\n" "$1" >&2
    exit 1
}

_exists() { command -v "${1}" &>/dev/null; }

curl -m 5 "http://wttr.in/${*:-}" 2>/dev/null || _exit_error "Could not connect to weather service."
