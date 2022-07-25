#!/bin/sh
# Start a new terminal with nvim-remote for Unity

server_path="/tmp/nvim_unity"
nvr_cmd="$HOME/.local/bin/nvr"
servers="$($nvr_cmd --serverlist)"

if [[ $(echo $servers | grep -o $server_path) ]]; then
    nvr --servername $server_path --remote-tab "$@"
else
    $TERMINAL_RUN /usr/bin/nvim --listen $server_path "$@"
fi
