#! /bin/bash

version=$(curl -s https://api.github.com/repos/ArchGPT/insomnium/releases/latest | grep "tag_name" | cut -d '"' -f 4 | sed 's/^core@//')
file_name="Insomnium.Core-$version.rpm"
output_dir="/tmp/$file_name"
download_url="https://github.com/ArchGPT/insomnium/releases/download/core@$version/$file_name"

# Remove old file
rm -rf $output_dir

# Download file
wget -c $download_url -O $output_dir

# Install
sudo dnf install -y $output_dir
