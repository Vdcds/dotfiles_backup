#!/bin/bash

STEP=5

case "$1" in
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +${STEP}%
        ;;
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -${STEP}%
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
esac

