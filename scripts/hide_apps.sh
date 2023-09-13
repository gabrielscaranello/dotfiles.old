#! /bin/bash

# Variables
APPS=(
    avahi-discover
    bssh
    bvnc
    nm-connection-editor
    nvim
    org.gnome.Extensions
    qv4l2
    qvidcap
)

for app in ${APPS[@]}; do
    location="/usr/share/applications/${app}.desktop"
    if [ -f "${location}" ]; then
        sudo sed -i "s/NoDisplay=\(true\|false\)//g" "${location}" > /dev/null
        echo "NoDisplay=true" | sudo tee -a "${location}" > /dev/null
    fi
done
