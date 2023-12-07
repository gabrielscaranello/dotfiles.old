#! /bin/bash

# Variables
SIZE=$(cat </proc/meminfo | awk '/MemTotal/ { printf("%.0f", ($2 / 1024 / 1024 / 2)) }')
MB_SIZE=$(echo "$SIZE" | awk '{ printf "%.0f", ($1 * 1024) }')

# Updating zram
sudo sed -i '/^zram-size/d' /etc/systemd/zram-generator.conf
echo "zram-size=max(ram/2, $MB_SIZE)" | sudo tee -a /etc/systemd/zram-generator.conf

# Adjust swappiness
sudo rm -rf /etc/sysctl.d/00-custom.conf
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.d/00-custom.conf
echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.d/00-custom.conf
