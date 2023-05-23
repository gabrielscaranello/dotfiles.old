#! /bin/bash

CURSOR_ICON="Bibata-Modern-Ice"
CURSOR_SIZE=20
GTK4_DIR="${HOME}/.config/gtk-4.0"
ICON_NAME="Papirus-Dark"
THEME_NAME="Catppuccin-Mocha-Standard-Blue-Dark"
THEME_DIR="/usr/share/themes/${THEME_NAME}"
WALLPAPER="file:///usr/share/backgrounds/gnome/blobs-l.svg"

# install theme and icons
install_theme_and_icons() {
    # Install Icons and Themes
    yay -Sy --noconfirm catppuccin-gtk-theme-mocha papirus-icon-theme papirus-folders-catppuccin-git bibata-cursor-theme-bin

    # Make settings
    ## GTK
    gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
    gsettings set org.gnome.desktop.wm.preferences theme "$THEME_NAME"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

    ## GTK4
    rm -rf $GTK4_DIR
    mkdir -p $GTK4_DIR
    ln -sf "${THEME_DIR}/gtk-4.0/assets" "${GTK4_DIR}/assets"
    ln -sf "${THEME_DIR}/gtk-4.0/gtk.css" "${GTK4_DIR}/gtk.css"
    ln -sf "${THEME_DIR}/gtk-4.0/gtk-dark.css" "${GTK4_DIR}/gtk-dark.css"

    ## Flatpak
    sudo flatpak override --filesystem=$HOME/.themes
    sudo flatpak override --env=GTK_THEME=$THEME_NAME

    ## Wallpaper and icons
    ### Icons
    papirus-folders -C adwaita
    gsettings set org.gnome.desktop.interface icon-theme "$ICON_NAME"
    gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_ICON"
    gsettings set org.gnome.desktop.interface cursor-size "$CURSOR_SIZE"
}

# Set wallpaper
set_wallpaper() {
    gsettings set org.gnome.desktop.background picture-uri "$WALLPAPER"
    gsettings set org.gnome.desktop.background picture-uri-dark "$WALLPAPER"
    gsettings set org.gnome.desktop.screensaver picture-uri "$WALLPAPER"
}

main() {
    echo "Starting look setup"
    echo $'Installing theme and icons\n'
    install_theme_and_icons
    echo $'\nAll theme and icons installed'
    echo "Setting wallpaper"
    set_wallpaper
    echo "Wallpaper setted"
    echo $'\nAll look settings done. Restart the session so that everything works as expected!'
}

main
