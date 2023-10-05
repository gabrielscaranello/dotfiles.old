#! /bin/bash

# Define variables
FILE_NAME="nvim.appimage"
OUTPUT_FILE="/tmp/$FILE_NAME"
DOWNLOAD_URL="https://github.com/neovim/neovim/releases/download/stable/$FILE_NAME"
DESTINATION_DIR="$HOME/.local/opt"

# Remove old file
rm -rf $OUTPUT_FILE

# Download file
wget -c $DOWNLOAD_URL -O $OUTPUT_FILE

# Move to folder
chmod u+x "${OUTPUT_FILE}"
mkdir -p $DESTINATION_DIR
mv $OUTPUT_FILE $DESTINATION_DIR

echo "Neovim installed..."