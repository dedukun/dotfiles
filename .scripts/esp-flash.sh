#!/bin/sh

_exit_error() {
    echo "ERROR: $1"
    exit 1
}

[ $# -lt 1 ] && _exit_error "You need to provide a device port"

[ ! -e "$1" ] && _exit_error "'$1' does not exist"

idf.py flash -b 2000000 -p $1 && picocom -b 115200 $1
