#!/bin/sh

_exit_error() {
    echo "ERROR: $1"
    exit 1
}

[ $# -lt 1 ] && _exit_error "You need to provide a device port"

[ ! -e "$1" ] && _exit_error "'$1' does not exist"

python3 "$IDF_PATH/components/esptool_py/esptool/esptool.py" \
    --port $1 \
    --baud 115200 \
    run
