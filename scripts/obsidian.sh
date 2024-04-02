#! /bin/bash

# Define variables
LAST_VERSION=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
FILE_NAME="obsidian_${LAST_VERSION}_amd64.deb"
OUTPUT_FILE="/tmp/$FILE_NAME"
DOWNLOAD_URL="https://github.com/obsidianmd/obsidian-releases/releases/download/v$LAST_VERSION/$FILE_NAME"

# Remove old file
rm -rf $OUTPUT_FILE

# Download file
wget -c $DOWNLOAD_URL -O $OUTPUT_FILE

# Install
sudo dpkg -i $OUTPUT_FILE

echo "Obsidian installed..."