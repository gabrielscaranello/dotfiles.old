#! /bin/bash

# Define variables
FILE_NAME="dbeaver-ce_latest_amd64.deb"
OUTPUT_FILE="/tmp/$FILE_NAME"
DOWNLOAD_URL="https://dbeaver.io/files/$FILE_NAME"

# Remove old file
rm -rf "$OUTPUT_FILE"

# Download file
wget -c "$DOWNLOAD_URL" -O "$OUTPUT_FILE"

# Install
sudo dpkg -i "$OUTPUT_FILE"

echo "DBeaver installed..."
