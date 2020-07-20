#!/bin/sh

# Start WM
if [ -z "$DESKTOP_SESSION" -a -x /usr/bin/ck-launch-session ]; then
    exec ck-launch-session dbus-launch --exit-with-session /usr/bin/bspwm
else
    exec dbus-launch --exit-with-session /usr/bin/bspwm
fi
