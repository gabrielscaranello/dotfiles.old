#! /bin/bash

# Variables
VERSION=$(curl -s https://api.github.com/repos/ArchGPT/insomnium/releases/latest | grep "tag_name" | cut -d '"' -f 4 | sed 's/^core@//')
FILE_NAME="Insomnium.Core-$VERSION.rpm"
DOWNLOAD_URL="https://github.com/ArchGPT/insomnium/releases/download/core@$VERSION/$FILE_NAME"
RPM_FILE="/tmp/$FILE_NAME"

# Remove old file
rm -rf $RPM_FILE

# Download file
wget -c $DOWNLOAD_URL -O $RPM_FILE

# Install Insomnium
sudo dnf install -y $RPM_FILE

echo "Insomnium is installed"