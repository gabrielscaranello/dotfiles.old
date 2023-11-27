#! /bin/bash

# Define variables
DOCUMENTS_DIR="Documents"
REPLACE_HOME='s,:home:,'"$HOME"',g'
USERS_DIR="$HOME/.config/user-dirs.dirs"

# Create directories
mkdir -p ~/.config/{gtk-3.0,gtk-4.0}
mkdir -p ~/.local/share/{color-schemes,plasma}
sudo mkdir -p /etc/timeshift
sudo mkdir -p /etc/sddm.conf.d
sudo mkdir -p /usr/share/sddm/themes/breeze

# Remove old files
sudo rm -rf ~/.config/flameshot /etc/timeshift/timeshift.json

# Defining timeshift values
if [ -f "$USERS_DIR" ]; then
	DOCUMENTS_DIR="$(grep 'XDG_DOCUMENTS_DIR' "$USERS_DIR" | awk -F'/' '{print $NF}' | cut -d'"' -f1)"
fi

# Copy timeshift settings
sed "$REPLACE_HOME" config/timeshift.json | sed 's,:documents_dir:,'"$DOCUMENTS_DIR"',g' | sudo tee /etc/timeshift/timeshift.json >/dev/null

# Copy other settings
cp -r ./config/flameshot ~/.config/flameshot
cp -r ./config/plasma/share/* ~/.local/share
cp -r ./config/plasma/config/* ~/.config
sudo cp ./config/sddm-kde.conf /etc/sddm.conf.d/kde_settings.conf
sudo cp ./config/plasma/share/sddm/theme.conf.user /usr/share/sddm/themes/breeze/theme.conf.user
sudo cp ./assets/wallpaper.png /usr/share/sddm/themes/breeze/default.png

# Replace home dir at plasma configs
sed -i "$REPLACE_HOME" ~/.config/plasma-org.kde.plasma.desktop-appletsrc
sed -i "$REPLACE_HOME" ~/.config/kscreenlockerrc
