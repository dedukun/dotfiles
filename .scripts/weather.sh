#!/bin/sh
# Simple wrapper for wttr.in

if [ -z "$1" ]; then
    curl wttr.in
else
    curl wttr.in/"$1"
fi
