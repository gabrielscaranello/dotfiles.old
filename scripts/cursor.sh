#! /bin/bash

VERSION=$(curl -s https://api.github.com/repos/ful1e5/Bibata_Cursor/releases/latest | grep "tag_name" | cut -d '"' -f 4)
FILE_NAME="Bibata-Modern-Ice.tar.xz"
OUTPUT_DIR="/tmp/$FILE_NAME"
DOWNLOAD_URL="https://github.com/ful1e5/Bibata_Cursor/releases/download/$VERSION/$FILE_NAME"
EXTRACT_DIR="/tmp"
TARGET_DIR="$HOME/.icons"

# Remove old file
rm -rf $OUTPUT_DIR $TARGET_DIR

# Download file
wget -c $DOWNLOAD_URL -O $OUTPUT_DIR

# Extract file
tar -xf $OUTPUT_DIR -C $EXTRACT_DIR

# Move file
mkdir -p "$TARGET_DIR"
mv "$EXTRACT_DIR/Bibata-Modern-Ice" "$TARGET_DIR"

echo "Bibata cursor installed"