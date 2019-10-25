#!/bin/bash
# This script makes sure that I'm using the right email when working in a GBT repository
COLOR='\033[0;35m'
NC='\033[0m' # No Color

function change_email()
{
    read -r -p "Do you want to configure this repository to use the GBT email? [Y/n] " change_email
    if [[ $change_email =~ ^[Yy]?$ ]]; then
        git config user.email "diogo.duarte@globaltronic.pt"
        git config user.name  "Diogo Duarte"
        echo "git email configured."
    fi
}

if [ "$1" = "commit" ];then
    if [ $(git remote -v \
         | head -n 1 | awk '{ print $2; }' \
         | cut -d '@' -f 2 | cut -d '/' -f 1 \
         | grep '^192\.168\....\....$' -o) ]; then
        if [ ! "$(git config --get user.email)" = "diogo.duarte@globaltronic.pt" ]; then
            printf "Your're not using the GBT email even though you are in a ${COLOR}local${NC} GBT repository.\n"
            change_email
        fi
    elif [ $(git remote -v \
         | head -n 1 | awk '{ print $2; }' \
         | cut -d '@' -f 2 | cut -d '/' -f 1 \
         | grep '^github.com:Globaltronic$' -o) ]; then
        if [ ! "$(git config --get user.email)" = "diogo.duarte@globaltronic.pt" ]; then
            printf "Your're not using the GBT email even though you are in a ${COLOR}GitHub${NC} GBT repository.\n"
            change_email
        fi
    fi
fi

git "$@"
exit $?
