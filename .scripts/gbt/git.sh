#!/bin/bash
# This script makes sure that I'm using the right email when working in a GBT repository
COLOR='\033[0;35m'
NC='\033[0m' # No Color

function change_email()
{
    printf "Do you want to configure this repository to use the GBT email? [Y/n] "
    if read -q; then
        git config user.email "diogo.duarte@globaltronic.pt"
        git config user.name  "Diogo Duarte"
        echo "git email configured."
    fi
    echo
}

function enable_cache()
{
    printf "Do you want to configure this repository to use cache credentials? [Y/n] "
    if read -q; then
        git config credential.helper cache
        echo "git cache configured."
    fi
    echo
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
elif [ "$1" = "pull" ];then
    if [ $(git remote -v \
         | head -n 1 | awk '{ print $2; }' \
         | cut -d '/' -f 3 \
         | grep '^git.overleaf.com$' -o) ]; then
        if [ ! "$(git config --get credential.helper)" = "cache" ]; then
            printf "Detect ${COLOR}Overleaf${NC} repository with no credentials cache.\n"
            enable_cache
        fi
    fi
fi

/usr/bin/git "$@"
exit $?
