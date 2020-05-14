#!/bin/sh
# This script wrappes ag to have default configurations (alias not really working with no argument)
if [ "$#" = 0 ]; then
    /usr/bin/ag
else
    /usr/bin/ag --color --nogroup "$@"
fi

exit $?
