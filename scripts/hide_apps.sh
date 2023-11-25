#! /bin/bash

# Variables
APPS=(
	assistant
	avahi-discover
	bssh
	btop
	bvnc
	designer
	linguist
	lstopo
	nm-connection-editor
	nvim
	qdbusviewer
	qv4l2
	qvidcap
)

for app in ${APPS[@]}; do
	location="/usr/share/applications/${app}.desktop"
	if [ -f "${location}" ]; then
		sudo sed -i "s/NoDisplay=\(true\|false\)//g" "${location}" >/dev/null
		echo "NoDisplay=true" | sudo tee -a "${location}" >/dev/null
	fi
done
