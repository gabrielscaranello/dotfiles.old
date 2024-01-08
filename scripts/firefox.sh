#! /bin/bash

# Remove old firefox
flatpak remove --assumeyes org.mozilla.firefox
flatpak remove --assumeyes --unused

# Add apt preference for firefox
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# Install
sudo apt update
sudo apt install -y firefox