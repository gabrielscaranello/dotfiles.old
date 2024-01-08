#! /bin/bash

version=$(curl -s https://api.github.com/repos/ful1e5/Bibata_Cursor/releases/latest | grep "tag_name" | cut -d '"' -f 4)
file_name="Bibata-Modern-Ice.tar.xz"
output_dir="/tmp/$file_name"
download_url="https://github.com/ful1e5/Bibata_Cursor/releases/download/$version/$file_name"
extract_dir="/tmp"
target_dir="$HOME/.icons"

# Remove old file
rm -rf $output_dir $target_dir

# Download file
wget -c $download_url -O $output_dir

# Extract file
tar -xf $output_dir -C $extract_dir

# Move file
mkdir -p "$target_dir"
mv "$extract_dir/Bibata-Modern-Ice" "$target_dir"

# defining cursor theme
gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'
gsettings set org.gnome.desktop.interface cursor-size 20

echo "Bibata cursor installed"