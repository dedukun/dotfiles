#!/bin/bash
# This script wrappes ag to have default configurations (alias not really working with no argument)
if [ "$#" = 0 ]; then
    ag
    exit 0
else
    ag --color --nogroup "$@"
    exit $?
fi
