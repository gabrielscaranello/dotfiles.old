#! /bin/bash

# Define variables
LAST_VERSION=$(curl -s "https://api.github.com/repos/ClementTsang/bottom/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
FILE_NAME="bottom_${LAST_VERSION}_amd64.deb"
OUTPUT_FILE="/tmp/$FILE_NAME"
DOWNLOAD_URL="https://github.com/ClementTsang/bottom/releases/download/$LAST_VERSION/$FILE_NAME"

# Remove old file
rm -rf $OUTPUT_FILE

# Download file
wget -c $DOWNLOAD_URL -O $OUTPUT_FILE

# Install
sudo dpkg -i $OUTPUT_FILE

echo "Bottom installed..."