#! /bin/bash

version=$(curl -s https://api.github.com/repos/telegramdesktop/tdesktop/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
file_name="tsetup.$version.tar.xz"
output_dir="/tmp/$file_name"
download_url="https://github.com/telegramdesktop/tdesktop/releases/download/v$version/$file_name"
extract_dir="/tmp/Telegram"
opt_dir="$HOME/.local/opt"
target_dir="$opt_dir/telegram-desktop"

# Remove old file
rm -rf $output_dir $target_dir $extract_dir

# Download file
wget -c $download_url -O $output_dir

# Extract file
mkdir -p $opt_dir
tar -xf $output_dir -C /tmp
mv $extract_dir $target_dir

echo "Telegram installed into $target_dir"