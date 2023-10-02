#! /bin/bash

version=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
file_name="lazygit_${version}_Linux_x86_64.tar.gz"
output_file="/tmp/$file_name"
download_url="https://github.com/jesseduffield/lazygit/releases/download/v$version/$file_name"
extract_dir="/tmp/lazygit"
target_dir="/usr/local/bin"

# Remove old file
rm -rf $output_file $extract_dir

# Download file
wget -c $download_url -O $output_file

# Extract file
mkdir -p $extract_dir
tar xf $output_file -C /tmp
sudo install $extract_dir $target_dir

echo "Lazygit installed..."