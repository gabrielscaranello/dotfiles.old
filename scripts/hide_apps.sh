#! /bin/bash

# Variables
APPS=(
    btop
    nvim
    org.gnome.Extensions
)

for app in ${APPS[@]}; do
    location="/usr/share/applications/${app}.desktop"
    if [ -f "${location}" ]; then
        sudo sed -i "s/NoDisplay=\(true\|false\)//g" "${location}" > /dev/null
        echo "NoDisplay=true" | sudo tee -a "${location}" > /dev/null
    fi
done