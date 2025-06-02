#!/bin/bash
# original source: https://gitlab.com/Nmoleo/i3-volume-brightness-indicator

# See README.md for usage instructions
bar_color="#7f7fff"
volume_step=1
brightness_step=10
max_volume=100

# Uses regex to get volume from pactl
function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

# Uses regex to get mute status from pactl
function get_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}

# Uses brightnessctl to get brightness
function get_brightness {
    brightnessctl g | awk '{printf "%d\n", $1 / 1000 }'
}

# Returns a mute icon, a volume-low icon, or a volume-high icon
function get_volume_icon {
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ] ; then
        volume_icon=""
    elif [ "$volume" -lt 50 ]; then
        volume_icon=""
    else
        volume_icon=""
    fi
}

# Always returns the same icon for brightness
function get_brightness_icon {
    brightness_icon=""
}

# Displays a volume notification using notify-send
function show_volume_notif {
    volume=$(get_mute)
    get_volume_icon
    notify-send -i audio-volume-muted -t 1000 "Volume" "$volume_icon $volume%" -h int:value:$volume -h string:x-canonical-private-synchronous:volume
}

# Displays a brightness notification using dunstify
function show_brightness_notif {
    brightness=$(get_brightness)
    get_brightness_icon
    notify-send -t 1000 -h string:x-dunst-stack-tag:brightness_notif -h int:value:$brightness "$brightness_icon $brightness%"
}

# Main function - Takes user input
case $1 in
    volume_up)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        pactl set-sink-volume @DEFAULT_SINK@ +$volume_step%
        show_volume_notif
        ;;

    volume_down)
        pactl set-sink-volume @DEFAULT_SINK@ -$volume_step%
        show_volume_notif
        ;;

    volume_mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        show_volume_notif
        ;;

    brightness_up)
        brightnessctl set $brightness_step%+
        show_brightness_notif
        ;;

    brightness_down)
        brightnessctl set $brightness_step%-
        show_brightness_notif
        ;;
esac

