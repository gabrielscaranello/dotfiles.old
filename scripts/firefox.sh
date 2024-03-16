#! /bin/bash

# Remove old firefox
flatpak remove --assumeyes org.mozilla.firefox
flatpak remove --assumeyes --unused
rm -rf "$HOME/.var/app/org.mozilla.firefox"

# Add repository
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc >/dev/null
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list >/dev/null

# Add apt preference for firefox
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla >/dev/null

# Install
sudo apt update
sudo apt install -y firefox
