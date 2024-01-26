#!/usr/bin/bash
# Start a new terminal with nvim-remote

if [ "$#" -lt 2 ]; then
    echo "Error: The server name and working folder MUST be given"
    exit 1
fi

server_path="/tmp/nvim_remote_$1"
shift # Remove server name from stdin
working_dir="$1"
shift # Remove working dir from stdin

if [ -S "$server_path" ]; then
    $TERMINAL_RUN /usr/bin/nvim --server "$server_path" --remote-tab "$@"
else
    $TERMINAL_OPEN "$working_dir" -- /usr/bin/nvim --listen "$server_path" "$@"
fi
