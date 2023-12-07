#! /bin/bash

# Create directories
sudo mkdir -p /etc/sddm.conf.d
sudo mkdir -p /usr/share/sddm/themes/breeze

# Copy timeshift settings

# Copy other settings
cp -r ./config/flameshot ~/.config/flameshot
sudo cp ./config/sddm-kde.conf /etc/sddm.conf.d/kde_settings.conf
sudo cp ./config/plasma/share/sddm/theme.conf.user /usr/share/sddm/themes/breeze/theme.conf.user
sudo cp ./assets/wallpaper.png /usr/share/sddm/themes/breeze/default.png
