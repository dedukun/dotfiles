#!/bin/sh
# Wrapper to start mailspring
# (it checks if the keyring is unlocked before prompting allowing mailspring to start)

if [ "$($SCRIPTS/auxiliar/gkey-check)" = "locked" ]; then
    notify-send -t 1500 -u critical "ERROR" "Keyring is locked, can't start MailSpring"
    exit 1
fi

mailspring "$@"
