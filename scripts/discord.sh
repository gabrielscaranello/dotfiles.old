#! /bin/bash

file_name="discord.deb"
output_file="/tmp/$file_name"
download_url="https://discord.com/api/download?platform=linux&format=deb"

# Remove old file
rm -rf $output_file

# Download file
wget -c $download_url -O $output_file

# Install
sudo dpkg -i $output_file

echo "Discord installed..."