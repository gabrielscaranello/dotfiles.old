#! /bin/bash

# Define variables
DOCUMENTS_DIR="Documents"
REPLACE_HOME='s,:home:,'"$HOME"',g'
USERS_DIR="$HOME/.config/user-dirs.dirs"

# Remove old files
sudo rm -rf ~/.config/flameshot /etc/timeshift/timeshift.json /etc/lightdm/slick-greeter.conf

# Defining timeshift values
if [ -f "$USERS_DIR" ]; then
  DOCUMENTS_DIR="$(grep 'XDG_DOCUMENTS_DIR' "$USERS_DIR" | awk -F'/' '{print $NF}' | cut -d'"' -f1)"
fi

# Copy timeshift settings
sed "$REPLACE_HOME" config/timeshift.json | sed 's,:documents_dir:,'"$DOCUMENTS_DIR"',g' | sudo tee /etc/timeshift/timeshift.json > /dev/null

# Copy other settings
sudo cp config/slick-greeter.conf /etc/lightdm/slick-greeter.conf
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-slick-greeter/' /etc/lightdm/lightdm.conf
cp -r ./config/flameshot ~/.config/flameshot