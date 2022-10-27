#!/bin/sh
# When switching between integrated and nvidia in optimus-manager, the display's name change in X.
# This script fixes this names in the configurations that are necessary.

_exit_error() {
    printf "ERROR: %s\n" "$1" >&2
    echo "For more help use argument -h or --help".
    exit 1
}

print_help() {
    printf "Optimus Manager Wrapper\n"
    printf "This wrapper script fixes scripts and configurations that use the displays.\n"
    printf "\n"
    printf "\t-f, --fix         Change the configurations to the current optimus-manager mode\n"
    printf "\t-h, --help        Prints help menu\n"
}

fix_display_configurations() {
    omw_eDP="$($SCRIPTS/auxiliar/get_display_names.sh -e)"
    omw_HMDI="$($SCRIPTS/auxiliar/get_display_names.sh --HDMI)"

    sed -i 's/${env:MONITOR:eDP.*}/${env:MONITOR:'$omw_eDP'}/g' $HOME/.config/polybar/config.ini
    sed -i 's/${env:MONITOR:HDMI.*}/${env:MONITOR:'$omw_HMDI'}/g' $HOME/.config/polybar/config.ini
}

fix_laptop_specific_configurations() {
    laptop=$(hostnamectl | grep "Hardware Vendor" | cut -d' ' -f4)

    if [ $laptop = "Lenovo" ]; then
        echo "Lenovo"
        wlan_int=wlo1
        eth_int=enp2s0
        bat_name=BAT1
        bat_adap=ACAD
        bat_full=100
        touchpad="MSFT0001:00 06CB:CE78 Touchpad"
    elif [ $laptop = "ASUSTeK" ]; then
        echo "Asus"
        wlan_int=wlan0
        eth_int=enp5s0
        # mount2=/second
        bat_name=BAT0
        bat_adap=AC0
        bat_full=98
        touchpad="ETPS/2 Elantech Touchpad"
        internal_keyboard="AT Translated Set 2 keyboard"

        xmodmap -e 'keycode  248 = grave asciitilde grave asciitilde' # set special key [248] to keysym '~' [which is keybinded in sxhkd]
    else
        echo "Unknown"
        return
    fi

    sed -i 's/interface = wl.*/interface = '$wlan_int'/g' $HOME/.config/polybar/config.ini
    sed -i 's/interface = enp.*/interface = '$eth_int'/g' $HOME/.config/polybar/config.ini

    if [ -z $mount2 ]; then
        sed -i 's/.*mount-2.*/# mount-2/g' $HOME/.config/polybar/config.ini
    else
        sed -i 's/.*mount-2.*/mount-2 = '$mount2'/g' $HOME/.config/polybar/config.ini
    fi

    sed -i 's/battery =.*/battery = '$bat_name'/g' $HOME/.config/polybar/config.ini
    sed -i 's/adapter =.*/adapter = '$bat_adap'/g' $HOME/.config/polybar/config.ini
    sed -i 's/full-at =.*/full-at = '$bat_full'/g' $HOME/.config/polybar/config.ini

    xinput set-prop "$touchpad" "libinput Natural Scrolling Enabled" 1
    xinput set-prop "$touchpad" "libinput Tapping Enabled" 1
    if [ -n "$internal_keyboard" ]; then
        xinput disable "$internal_keyboard"
    fi
}

fix_configurations() {
    fix_display_configurations
    fix_laptop_specific_configurations
}

while [ $# -gt 0 ]; do
    omw_key="$1"

    case $omw_key in
        -f | --fix)
            fix_configurations
            shift # past argument
            ;;
        -h | --help)
            shift # past argument
            print_help
            exit
            ;;
        *)
            _exit_error "Invalid argument '$1'."
            ;;
    esac
done
