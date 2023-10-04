#! /bin/bash

file_name="nvim.appimage"
output_file="/tmp/$file_name"
download_url="https://github.com/neovim/neovim/releases/download/stable/$file_name"
destination_dir="$HOME/.local/opt"

# Remove old file
rm -rf $output_file

# Download file
wget -c $download_url -O $output_file

# Move to folder
chmod u+x "${output_file}"
mkdir -p $destination_dir
mv $output_file $destination_dir

echo "Neovim installed..."