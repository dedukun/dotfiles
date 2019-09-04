#!/bin/bash
# This script makes sure that I'm using the right email when working in a GBT repository
if [ "$1" = "commit" ];then
    if [ $(git remote -v \
         | head -n 1 | awk '{ print $2; }' \
         | cut -d '@' -f 2 | cut -d '/' -f 1 \
         | grep '^192\.168\....\....$' -o) ]; then
        if [ ! "$(git config --get user.email)" = "diogo.duarte@globaltronic.pt" ]; then
            echo "Your're not using the GBT email even though you are in a GBT repository."
            read -r -p "Do you want to configure this repository to use the GBT email? [Y/n] " change_email
            if [[ $change_email =~ ^[Yy]?$ ]]; then
                git config user.email "diogo.duarte@globaltronic.pt"
                git config user.name  "Diogo Duarte"
                echo "git email configured."
            fi
        fi
    fi
fi

git "$@"
exit $?
