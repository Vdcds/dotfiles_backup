#!/bin/bash

# Open terminal on workspace 1
i3-msg "workspace 1; exec i3-sensible-terminal"
sleep 1

# Open Chrome on workspace 2
i3-msg "workspace 2; exec google-chrome --new-instance"
sleep 1

# Open VS Code on workspace 3
i3-msg "workspace 3; exec code"
sleep 1

# Open Firefox on workspace 4
i3-msg "workspace 4; exec firefox --new-instance"
sleep 1

# Open WhatsApp Web on workspace 5
i3-msg "workspace 5; exec google-chrome --app='https://web.whatsapp.com'"
sleep 1

# Open YouTube on workspace 5
i3-msg "workspace 5; exec google-chrome --app='https://www.twitter.com'"
sleep 2
# Open discord on workspace 5
i3-msg "workspace 6; exec discord --new-instance"
sleep 7


# Open YouTube Music on workspace 7
i3-msg "workspace 7; exec google-chrome --app='https://music.youtube.com'"

