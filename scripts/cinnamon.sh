#! /bin/bash

# Define variables
APPLETS=("color-picker@fmete" "qredshift@quintao")
EXTENSIONS=("transparent-panels@germanfr")
DOWNLOAD_URL="https://cinnamon-spices.linuxmint.com/files"
CINNAMON_DIR="$HOME/.local/share/cinnamon"
CINNAMON_CONFIG_DIR="$HOME/.config/cinnamon"
APPLETS_DIR="$CINNAMON_DIR/applets"
EXTENSIONS_DIR="$CINNAMON_DIR/extensions"

# Install function
install() {
	local package=("$1")
	local type="$2"
	local destination="$3"
	local file_name="$package.zip"
	local output_file="/tmp/$file_name"
	local download_url="$DOWNLOAD_URL/$type/$file_name"
	wget -c "$download_url" -O "$output_file" >/dev/null 2>&1
	unzip "$output_file" -d "$destination" >/dev/null 2>&1
}

# clean and recreate destination
rm -rf "$APPLETS_DIR" "$EXTENSIONS_DIR" "$CINNAMON_CONFIG_DIR"
mkdir -p "$APPLETS_DIR" "$EXTENSIONS_DIR" "$CINNAMON_CONFIG_DIR"

# Install
for applet in "${APPLETS[@]}"; do install "${applet}" "applets" "$APPLETS_DIR"; done
for extension in "${EXTENSIONS[@]}"; do install "${extension}" "extensions" "$EXTENSIONS_DIR"; done

# Copy config
cp -r ./config/cinnamon/* "$CINNAMON_CONFIG_DIR"
