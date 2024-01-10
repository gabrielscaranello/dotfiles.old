#! /bin/bash

# Remove old files
sudo rm -rf ~/.config/flameshot /etc/lightdm/slick-greeter.conf

# Copy other settings
sudo cp config/slick-greeter.conf /etc/lightdm/slick-greeter.conf
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-slick-greeter/' /etc/lightdm/lightdm.conf
cp -r ./config/flameshot ~/.config/flameshot
