#!/bin/bash

# Load the layout
i3-msg "workspace IDE; append_layout ~/.config/i3/i3layout.json"

# Give some time for the layout to be applied
sleep 1

# Launch applications
kitty --class nvim -e nvim &
sleep 0.5
kitty --class terminal1 &
sleep 0.5
kitty --class terminal2 &
