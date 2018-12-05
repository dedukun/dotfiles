#!/bin/bash
print_help () {
    echo "This script helps finding slackbuilds in Ponce's slackbuilds repository."
    echo "You can get the repository at https://github.com/Ponce/slackbuilds"
    echo -e "\t-r, --repository   Change the repository folder location"
    echo -e "\t-s, --show         Show only it the path to the slackbuild"
    echo -e "\t-h, --help         Prints help menu"
}

function unset_vars(){
    unset SLKF_SOURCE
    unset SLKF_BUILD
    unset SLKF_SHOW
    unset SLKF_KEY
}

SLKF_SOURCE="$HOME/Repositories/slackbuilds"
while [[ $# -gt 0 ]]
do
    SLKF_KEY="$1"

    case $SLKF_KEY in
        -r|--repository)
        SLKF_SOURCE="$2"
        shift # past argument
        shift # past value
        ;;
        -s|--show)
        shift # past argument
        SLKF_SHOW=YES
        ;;
        -h|--help)
        shift # past argument
        print_help
        return
        ;;
        [a-zA-Z]*)
        SLKF_BUILD="$1"
        shift # past argument
        ;;
        *)
        echo "Invalid argument '$1'."
        echo "For more help use argument -h or --help".
        shift # past argument
        return
        ;;
    esac
done

if [[ ! -n $SLKF_BUILD ]]; then
    echo "You need to pass the name of the slackbuild."

    unset_vars
    return
fi

if ! test -d $SLKF_SOURCE ; then
    echo "Given folder '$SLKF_SOURCE' doesn't exists."

    unset_vars
    return
fi

BUILD=$(find ~/Repositories/slackbuilds/* -type d -name $SLKF_BUILD)

if [[ ! "$BUILD" ]]; then
    echo "'$SLKF_BUILD' build not found!"

    unset_vars
    return
fi

if [[ -n $SLKF_SHOW ]]; then
    echo $BUILD
else
    cd $BUILD
fi

unset_vars
