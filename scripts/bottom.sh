#! /bin/bash

version=$(curl -s "https://api.github.com/repos/ClementTsang/bottom/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
file_name="bottom_${version}_amd64.deb"
output_fiile="/tmp/$file_name"
download_url="https://github.com/ClementTsang/bottom/releases/download/$version/$file_name"

# Remove old file
rm -rf $output_fiile

# Download file
wget -c $download_url -O $output_fiile

# Install
sudo dpkg -i $output_fiile

echo "Bottom installed..."