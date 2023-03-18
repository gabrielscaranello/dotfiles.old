#! /bin/sh

GTK_THEME_URL="https://github.com/lassekongo83/adw-gtk3/releases/download/v4.3/adw-gtk3v4-3.tar.xz"
THEME_NAME="adw-gtk3-dark"
THEME_LOCATION="/tmp/$THEME_NAME.tar.xz"
THEMES_PATH="$HOME/.themes"
CURSOR_ICON="Bibata-Modern-Ice"
CURSOR_SIZE=20
ICON_NAME="Papirus-Dark"
ICONS="papirus-icon-theme papirus-folders-git bibata-cursor-theme-bin"
WALLPAPER="file:///usr/share/backgrounds/archlinux/gritty.png"

# install theme and icons
install_theme_and_icons() {
    # Install GTK Theme
    mkdir -p "$THEMES_PATH"
    wget -c "$GTK_THEME_URL" -O "$THEME_LOCATION"
    tar -xf "$THEME_LOCATION" -C "$THEMES_PATH"
    
    # Install Icons Package
    $(echo "yay -Sy --noconfirm $ICONS")
    
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
