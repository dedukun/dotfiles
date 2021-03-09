#!/bin/sh
# Start a PulseAudio module through TCP to connect to Android Phone
#
# based on:https://github.com/vindecodex/PCAudioToAndroid

tray_icon="/home/dedukun/.local/share/Steam/tenfoot/resource/images/music/musicguide_icon.png"

_unload_module() {
    module_number="$(pactl list | grep tcp -B1 | grep M | sed 's/[^0-9]//g')"

    # Check if already running
    if [ -n "$module_number" ]; then
        notify-send -t 1500 "Share Audio" "Unload TCP Module"

        pactl unload-module "$module_number" >/dev/null 2>&1
        unload_exit_code=$?

        if [ "$unload_exit_code" -ne 0 ]; then
            notify-send -u critical -t 1500 "Share Audio" "Error unloading module"
        fi

        # if yad running in another run of this script, kill it
        duplicate_yad="$(ps aux | grep yad | grep 'Share Audio' | awk '{print $2; }')"
        [ -n "$duplicate_yad" ] && kill -9 "$duplicate_yad"

        exit $unload_exit_code
    fi
}

_load_module() {
    # choose sample rate
    sample_rate="$(echo '24000\n44100\n48000' | rofi -dmenu -l 3 -p 'Sample Rate:')"

    notify-send -t 1500 "Share Audio" "Load TCP Module [$sample_rate]"

    # load module
    pactl load-module module-simple-protocol-tcp rate="$sample_rate" format=s16le channels=2 source=0 record=true port=8000 >/dev/null 2>&1
    load_exit_code=$?

    if [ "$load_exit_code" -ne 0 ]; then
        notify-send -u critical -t 1500 "Share Audio" "Error loading module"
        exit $load_exit_code
    fi
}

# if already running, unload module and stop
_unload_module

# load module
_load_module

# add icon to icon tray
if [ -f "$tray_icon" ]; then
    yad --notification --title="Share Audio" --text="Share Audio (click to stop)" --image="$tray_icon"
else
    yad --notification --title="Share Audio" --text="Share Audio (click to stop)"
fi

# after click in notification, unload module
_unload_module
