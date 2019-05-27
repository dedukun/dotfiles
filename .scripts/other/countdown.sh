#!/bin/sh
# Countdown script
#
# Source:
# https://www.unix.com/shell-programming-and-scripting/98889-display-runnning-countdown-bash-script.html
print_help () {
    echo "Countdown script."
    echo "Example: $0 2m | 02:00"
    printf "\t-h, --help        This help page\n"
}

[ "$(echo "01:1:2" | grep -q -E "[0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}")" ] && echo "YES"

while [ $# -gt 0 ]
do
    count_key="$1"

    case $count_key in
        -h|--help)
        shift # past argument
        print_help
        exit 0
        ;;
        *)
        echo "Invalid argument '$1'."
        echo "For more information use argument -h or --help".
        shift # past argument
        exit 1
        ;;
    esac
done

IFS=:
set -- "$@"
secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
while [ $secs -gt 0 ]; do
    sleep 1 &
    printf "\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
    secs=$(( secs - 1 ))
    wait
done
echo
