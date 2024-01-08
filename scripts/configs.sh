#! /bin/bash

# Remove old files
sudo rm -rf ~/.config/flameshot

# Copy other settings
cp -r ./config/autostart ~/.config/autostart
cp -r ./config/flameshot ~/.config/flameshot