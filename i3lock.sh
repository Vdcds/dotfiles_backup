#!/bin/bash

# Dependencies: i3lock, imagemagick, scrot

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check for dependencies
for cmd in scrot convert identify i3lock; do
    if ! command_exists "$cmd"; then
        echo "Error: $cmd is not installed." >&2
        exit 1
    fi
done

# Create a temporary directory
TMPDIR=$(mktemp -d)
echo "Created temporary directory: $TMPDIR"

# Take a screenshot
scrot "$TMPDIR/screen.png"
if [ $? -ne 0 ]; then
    echo "Error: Failed to take a screenshot." >&2
    exit 1
fi
echo "Screenshot taken."

# Blur the screenshot
convert "$TMPDIR/screen.png" -blur 0x5 "$TMPDIR/screen_blur.png"
if [ $? -ne 0 ]; then
    echo "Error: Failed to blur the screenshot." >&2
    exit 1
fi
echo "Screenshot blurred."

# Get current time
CURRENT_TIME=$(date +"%H:%M")
echo "Current time: $CURRENT_TIME"

# Add clock and to-do list to the lockscreen
TODO_TEXT="Drink water\nWalk for 2 hours\nEat good food"
convert "$TMPDIR/screen_blur.png" \
    -font DejaVu-Sans-Bold -pointsize 100 -fill white -gravity center -annotate +0-200 "$CURRENT_TIME" \
    -font DejaVu-Sans-Bold -pointsize 30 -fill white -gravity center -annotate +0+100 "$TODO_TEXT" \
    "$TMPDIR/lockscreen_with_todo.png"
if [ $? -ne 0 ]; then
    echo "Error: Failed to add text to the lockscreen." >&2
    exit 1
fi
echo "Clock and to-do list added."

# Lock the screen with the generated image
i3lock -i "$TMPDIR/lockscreen_with_todo.png"
if [ $? -ne 0 ]; then
    echo "Error: Failed to lock the screen." >&2
    exit 1
fi
echo "Screen locked."

# Clean up temporary files
rm -r "$TMPDIR"
echo "Temporary files cleaned up."
