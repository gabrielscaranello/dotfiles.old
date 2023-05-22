#! /bin/bash

THEME_NAME="adw-gtk3-dark"
CURSOR_ICON="Bibata-Modern-Ice"
CURSOR_SIZE=20
ICON_NAME="Papirus-Dark"
ICONS="papirus-icon-theme papirus-folders-git bibata-cursor-theme-bin"
WALLPAPER="file:///usr/share/backgrounds/gnome/blobs-l.svg"

# install theme and icons
install_theme_and_icons() {
    # Install GTK Theme
    mkdir -p "$THEMES_PATH"
    wget -c "$GTK_THEME_URL" -O "$THEME_LOCATION"
    tar -xf "$THEME_LOCATION" -C "$THEMES_PATH"

    # Install Icons and Themes
    yay -Sy --noconfirm papirus-icon-theme papirus-folders-git bibata-cursor-theme-bin adw-gtk3

    # Make settings
    ## GTK
    gsettings set org.gnome.desktop.interface gtk-theme "$THEME_NAME"
    gsettings set org.gnome.desktop.wm.preferences theme "$THEME_NAME"
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

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
