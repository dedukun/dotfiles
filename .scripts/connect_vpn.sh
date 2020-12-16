#!/bin/sh

list_vpns() {
    list_name_vpn="$(nmcli --fields name,type connection show --order type | awk '{gsub(/^ +| +$/,"")} {if($NF == "vpn") print}')"

    echo "$(echo $list_name_vpn | rev | cut -d' ' -f2- | rev)"
}

choose_vpn() {
    list_vpns="$(list_vpns)"
    num_vpns="$(echo $list_vpns | wc -l)"

    echo "$(echo $list_vpns | rofi -dmenu -p 'VPN' -i -l $num_vpns)"
}

connect_vpn() {
    choosen_vpn="$(choose_vpn)"

    [ -z "$choosen_vpn" ] && exit 0

    nmcli connection up id "$choosen_vpn" --ask

    if [ "$choosen_vpn" = "GBT_VPN" ]; then
        sudo ip route del default dev ppp0
        sudo ip route add
    fi
}

disconnect_vpn() {
    choosen_vpn="$(choose_vpn)"

    [ -z "$choosen_vpn" ] && exit 0

    nmcli connection down id "$choosen_vpn" --ask
}

com="$(echo 'Connect\nDisconnect\nList' | rofi -dmenu -p 'Command' -l 3 -i)"

case $com in
    Connect)
        echo "-$com"
        connect_vpn
        ;;

    Disconnect)
        echo "-$com"
        disconnect_vpn
        ;;

    List)
        echo "-$com"
        list_vpns
        ;;

    *)
        echo "Unkown command '$com'"
        exit 1
        ;;

esac

