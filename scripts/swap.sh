#! /bin/bash

# Variables
SIZE=$(cat </proc/meminfo | awk '/MemTotal/ { printf("%.0f", ($2 / 1024 / 1024 / 2)) }')

sudo swapoff --all
sudo zramswap stop
sudo sed -i '/^PERCENT/d' /etc/default/zramswap
sudo sed -i '/^PRIORITY/d' /etc/default/zramswap

# Updating zram
echo 'PERCENT=50' | sudo tee -a /etc/default/zramswap
echo 'PRIORITY=100' | sudo tee -a /etc/default/zramswap

# Adjust swappiness
sudo rm -rf /etc/sysctl.d/00-custom.conf
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.d/00-custom.conf
echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.d/00-custom.conf

# start
sudo zramswap start