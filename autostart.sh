#!/bin/bash

dunst &
# slstatus &
feh --bg-fill ~/Pictures/wallpapers/1337725.jpeg
pamixer --set-volume 40
dunstify "Welcome!"

# Startup apps
#flatpak run org.mozilla.firefox &
#flatpak run com.spotify.Client &
#discord-canary &

# Functions

clock(){
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
            printf " $volume_level%%"
        fi
}


while true; do
	sleep 1 && xsetroot -name "| $(wifi) | $(volume) | $(clock) | $(battery) ♥"
done

