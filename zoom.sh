#!/bin/bash

current=$(xrandr --current --verbose | grep -m 1 -i scale | cut -f2 -d' ')

if [ "$1" = "in" ]; then
  new=$(echo "$current + 0.1" | bc)
elif [ "$1" = "out" ]; then
  new=$(echo "$current - 0.1" | bc)
else
  echo "Usage: $0 [in|out]"
  exit 1
fi

xrandr --output $(xrandr | grep primary | cut -f1 -d' ') --scale ${new}x${new}
