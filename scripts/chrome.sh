#! /bin/bash

# Define variables
FILE_NAME="google-chrome-stable_current_amd64.deb"
OUTPUT_FILE="/tmp/$FILE_NAME"
DOWNLOAD_URL="https://dl.google.com/linux/direct/$FILE_NAME"

# Remove old file
rm -rf "$OUTPUT_FILE"

# Download file
wget -c "$DOWNLOAD_URL" -O "$OUTPUT_FILE"

# Install
sudo dpkg -i "$OUTPUT_FILE"

echo "Google Chrome installed..."
