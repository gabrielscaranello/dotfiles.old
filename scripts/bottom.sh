#! /bin/bash

version=$(curl -s "https://api.github.com/repos/ClementTsang/bottom/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
file_name="bottom_${version}_amd64.deb"
output_file="/tmp/$file_name"
download_url="https://github.com/ClementTsang/bottom/releases/download/$version/$file_name"

# Remove old file
rm -rf $output_file

# Download file
wget -c $download_url -O $output_file

# Install
sudo dpkg -i $output_file

echo "Bottom installed..."