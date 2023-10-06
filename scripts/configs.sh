#! /bin/bash

# Define variables
DOCUMENTS_DIR="Documents"
REPLACE_HOME='s,:home:,'"$HOME"',g'
USERS_DIR="$HOME/.config/user-dirs.dirs"

# Remove old files
sudo rm -rf ~/.config/autostart ~/.config/plank ~/.config/flameshot ~/.psensor /etc/lightdm/slick-greeter.conf /etc/timeshift/timeshift.json

# Defining timeshift values
if [ -f "$USERS_DIR" ]; then
  DOCUMENTS_DIR="$(grep 'XDG_DOCUMENTS_DIR' "$USERS_DIR" | awk -F'/' '{print $NF}' | cut -d'"' -f1)"
fi

# Copy timeshift settings
sed "$REPLACE_HOME" config/timeshift.json | sed 's,:documents_dir:,'"$DOCUMENTS_DIR"',g' | sudo tee /etc/timeshift/timeshift.json > /dev/null

# Copy slick gretter settings
sed "$REPLACE_HOME" config/slick-greeter.conf | sudo tee /etc/lightdm/slick-greeter.conf > /dev/null

# Copy other settings
cp -r ./config/autostart ~/.config/autostart
cp -r ./config/flameshot ~/.config/flameshot
cp -r ./config/plank ~/.config/plank
cp -r ./config/psensor ~/.psensor