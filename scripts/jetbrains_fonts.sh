#! /bin/bash

# Define variables
FILE_NAME="JetBrainsMono.zip"
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FILE_NAME"
OUTPUT_DIR="/tmp/$FILE_NAME"
TMP_DIR="/tmp/JetBrainsMono"
FONT_DIR="$TMP_DIR/JetBrainsMonoNerdFont"
FONTS_TO_INSTALL="$FONT_DIR-Regular.ttf $FONT_DIR-Bold.ttf $FONT_DIR-Italic.ttf"
TARGET_DIR="$HOME/.fonts"

# Remove old file
rm -rf $OUTPUT_DIR $TMP_DIR

# Download file
wget -c $DOWNLOAD_URL -O $OUTPUT_DIR

# Extract file
unzip $OUTPUT_DIR -d $TMP_DIR

# Move fonts
mkdir -p $TARGET_DIR
cp $FONTS_TO_INSTALL $TARGET_DIR

# Update font cache
fc-cache -f