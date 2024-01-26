#!/bin/sh

ssh_ip=$(echo | rofi -dmenu -p "IP:" -l 0)

echo "URL: $ssh_ip"
if [ $(nmap "$ssh_ip" -PN | grep "ssh" | grep -q "open") ]; then
    echo "YES"
else
    echo "NO"
fi

# ssh_user=$(echo | rofi -dmenu -p "User:" -l 0)
# ssh_options=$(echo | rofi -dmenu -p "Options:" -l 0)

# wezterm ssh "$ssh_options" "$ssh_user:$ssh_ip"
