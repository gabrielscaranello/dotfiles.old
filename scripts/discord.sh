#! /bin/bash

# Define variables
FILE_NAME="discord.deb"
OUTPUT_FILE="/tmp/$FILE_NAME"
DOWNLOAD_URL="https://discord.com/api/download?platform=linux&format=deb"

# Remove old file
rm -rf $OUTPUT_FILE

# Download file
wget -c $DOWNLOAD_URL -O $OUTPUT_FILE

# Install
sudo dpkg -i $OUTPUT_FILE

echo "Discord installed..."