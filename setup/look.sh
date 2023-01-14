#! /bin/sh

GIT_URL="https://github.com/vinceliuice/Graphite-gtk-theme.git"
THEME_NAME="Graphite-blue-Dark-nord"
LOCATION="/tmp/$THEME_NAME"
PARAMS="-l -s standard -c dark --tweaks nord black darker rimless normal -t blue"
ICONS="papirus-icon-theme papirus-folders-git bibata-cursor-theme-bin"
ICON_NAME="Papirus-Dark"
CURSOR_ICON="Bibata-Modern-Ice"
CURSOR_SIZE=20
WALLPAPER="$(pwd)/look/wallpaper.jpg"
FINAL_WALLPAPER="$HOME/.local/share/backgrounds/mountain_jaws.jpg"

# Install GTK Theme
git clone "$GIT_URL" "$LOCATION"
"$LOCATION"/install.sh "$PARAMS"

# Install Icons Package
paru -Sy --noconfirm "$ICONS"

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

### Wallpaper
cp "$WALLPAPER" "$FINAL_WALLPAPER"
gsettings set org.gnome.desktop.background picture-uri "$FINAL_WALLPAPER"
gsettings set org.gnome.desktop.background picture-uri-dark "$FINAL_WALLPAPER"
gsettings set org.gnome.desktop.screensaver picture-uri "$FINAL_WALLPAPER"

# Flatpak GTK setup
stylepak install-system
stylepak install-user
