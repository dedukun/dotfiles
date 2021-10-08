#!/bin/sh
#based on: https://github.com/polybar/polybar-scripts/blob/master/polybar-scripts/vpn-networkmanager-status/vpn-networkmanager-status.sh

vpn="$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep vpn | head -1 | cut -d ':' -f 1)"

if [ -n "$vpn" ]; then
    echo "$vpn"
else
    echo ""
fi
