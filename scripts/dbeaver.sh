#! /bin/bash

# Variables
FILE_NAME="dbeaver-ce-latest-stable.x86_64.rpm"
DOWNLOAD_URL="https://dbeaver.io/files/$FILE_NAME"
RPM_FILE="/tmp/$FILE_NAME"

# Remove old file
rm -rf $RPM_FILE

# Download file
wget -c $DOWNLOAD_URL -O $RPM_FILE

# Install DBeaver
sudo dnf install -y $RPM_FILE

echo "DBeaver is installed"