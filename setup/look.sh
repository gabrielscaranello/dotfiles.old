#! /bin/sh

GIT_URL="https://github.com/vinceliuice/Orchis-theme.git"
THEME_NAME="Orchis-Dark-Nord"
THEME_LOCATION="/tmp/$THEME_NAME"
THEME_PARAMS="-c dark -s standard -l --tweaks compact primary macos submenu nord"
ICONS="papirus-icon-theme papirus-folders-git bibata-cursor-theme-bin"
ICON_NAME="Papirus-Dark"
CURSOR_ICON="Bibata-Modern-Ice"
CURSOR_SIZE=20
DCONF="$(pwd)/look/dconf-settings"
WALLPAPER="file:///usr/share/backgrounds/archlinux/gritty.png"

GNOME_EXTENSIONS=(
  3193  # Blur my Shell
  517   # Caffeine
  779   # Clipboard Indicator
  3396  # Color Picker
  97    # Coverflow Alt-Tab
  4655  # Date Menu Formatter
  2224  # Easy Docker Containers
  1162  # Emoji Selector
  2114  # Order Gnome Shell extensions
  1514  # Rounded Corners
  5237  # Rounded Window Corners
  2890  # Tray Icons: Reloaded
  19    # User Themes
  1460  # Vitals
  4228  # Wireless HID
)

# install theme and icons
install_theme_and_icons() {
  # Install GTK Theme
  git clone "$GIT_URL" "$THEME_LOCATION"
  $(echo "$THEME_LOCATION/install.sh $THEME_PARAMS")

  # Install Icons Package
  $(echo "yay -Sy --noconfirm $ICONS")

  # Make settings
  ## GTK
  gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
  gsettings set org.gnome.desktop.wm.preferences theme "$THEME_NAME"
  mkdir -p ~/.config/gtk-4.0
  rm -rf ~/.config/gtk-4.0/settings.ini

  cat >> ~/.config/gtk-4.0/settings.ini << EOF
  [Settings]
  gtk-application-prefer-dark-theme=1 
EOF

  ## Wallpaper and icons
  ### Icons
  papirus-folders -C adwaita
  gsettings set org.gnome.desktop.interface icon-theme "$ICON_NAME"
  gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_ICON"
  gsettings set org.gnome.desktop.interface cursor-size "$CURSOR_SIZE"

  # Flatpak GTK setup
  stylepak install-system
  stylepak install-user
}

# Set wallpaper
set_wallpaper() {
  gsettings set org.gnome.desktop.background picture-uri "$WALLPAPER"
  gsettings set org.gnome.desktop.background picture-uri-dark "$WALLPAPER"
  gsettings set org.gnome.desktop.screensaver picture-uri "$WALLPAPER"
}

# install gnome extensions
install_gnome_extensions() {
  # Add helper
  yay -S --noconfirm gnome-shell-extension-installer

  # Install extensions
  for extension in ${GNOME_EXTENSIONS[@]}; do
    gnome-shell-extension-installer --yes "$extension"
  done

  # Remove helper
  yay -Rns --noconfirm gnome-shell-extension-installer

  ### load dconfig
  dconf load / < "$DCONF"
}

main() {
  echo "Starting look setup"
  echo $'Installing theme and icons\n'
  install_theme_and_icons
  echo $'\nAll theme and icons installed'
  echo "Setting wallpaper"
  set_wallpaper
  echo "Wallpaper setted"

  echo $'\nInstalling gnome extensions...'
  install_gnome_extensions
  echo "Gnome extensions installed"
  echo $'\nAll look settings done. Restart the session so that everything works as expected!'
}

main

