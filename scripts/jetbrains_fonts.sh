#! /bin/bash

file_name="JetBrainsMono.zip"
download_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$file_name"
output_dir="/tmp/$file_name"
tmp_dir="/tmp/JetBrainsMono"
font_dir="$tmp_dir/JetBrainsMonoNerdFont"
fonts="$font_dir-Regular.ttf $font_dir-Bold.ttf $font_dir-Italic.ttf"
target_dir="$HOME/.fonts"

# Remove old file
rm -rf $output_dir $tmp_dir

# Download file
wget -c $download_url -O $output_dir

# Extract file
unzip $output_dir -d $tmp_dir

# Move fonts
mkdir -p $target_dir
cp $fonts $target_dir

# Update font cache
fc-cache -f