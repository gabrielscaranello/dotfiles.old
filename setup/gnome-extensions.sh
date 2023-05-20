#! /bin/sh

DCONF="$(pwd)/look/dconf-settings"

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

echo $'Installing gnome extensions...\n'
install_gnome_extensions
echo "Gnome extensions installed"
echo $'\nRestart the session so that everything works as expected!'
