#!/bin/bash

# Slock
xautolock -time 5 -locker slock -detectsleep &

dunst &
# slstatus &
feh --bg-fill ~/Pictures/1337228.jpeg
pamixer --set-volume 40
dunstify "Welcome!"
export PATH="/var/lib/flatpak/exports/bin/:$PATH" &

# Startup apps
brave-browser &
flatpak run com.spotify.Client &
flatpak run com.discordapp.Discord &

# Functions
storage_info() {
	storage=$(df -h /home/ | awk 'NR==2{print $3, $2}')
	printf " $storage"
}

clock() {
	printf "$(date '+%A %I:%M %p')"
}

battery() {
	battery_status=$(cat /sys/class/power_supply/ACAD/online)
	battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
	if [ "$battery_status" = "Charging," ]; then
		printf "  $battery_percentage%%"
	elif [ "$battery_status" = "Discharging," ]; then
		if [ "$battery_percentage" -lt 20 ]; then
			printf "  $battery_percentage%%"
		else
			printf "  $battery_percentage%%"
		fi
	else
		printf "  $battery_percentage%%"
	fi
}

wifi() {
	wifi_name=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d: -f2)
	if [ -n "$wifi_name" ]; then
		printf "  $wifi_name"
	else
		printf "  Not Connected"
	fi
}

volume() {
	volume_level=$(pamixer --get-volume)
	muted=$(pamixer --get-mute)
	if [ "$muted" = "true" ]; then
		printf " Muted"
	else
		printf "  $volume_level%%"
	fi
}

while true; do
	sleep 1 && xsetroot -name "[ $(wifi) ] [ $(volume) ] [ $(clock) ] [ $(storage_info) ] [ $(battery) ♥ ] "
done

while true; do
	# Log stderror to a file
	dwm 2>~/.dwm.log
	# No error logging
	#dwm >/dev/null 2>&1
done
