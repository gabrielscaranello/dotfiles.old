# Makefile for arch

yay:
	# Installing yay
	# Installing dependencies
	@sudo pacman -S --needed --noconfirm git base-devel
	# Cloning yay
	@rm -rf /tmp/yay
	@git clone https://aur.archlinux.org/yay.git /tmp/yay
	# Installing yay
	@cd /tmp/yay && makepkg -si
	# Yay gendb
	yay -Y --gendb

install_system: yay
	# Updating system packages
	@yay -Suuy --noconfirm
	# Installing system packages
	@yay -S --noconfirm $$(cat ./system_packages | tr '\n' ' ')

install_amd:
	# Install packages from AMD
	@yay -S --noconfirm $$(cat ./amd_packages | tr '\n', ' ')

install_flatpak:
	# Installing flatpak apps
	@flatpak install flathub --assumeyes $$(cat ./flatpak_packages | tr '\n' ' ')

install_gnome_extensions:
	# Installing gnome extensions
	# Intalling helper
	@yay -S --noconfirm gnome-shell-extension-installer
	# Installing extensions
	@for i in $$(sed "s/[^0-9]//g" ./gnome_extensions); do gnome-shell-extension-installer --yes "$$i"; done
	# Removing helper
	@yay -Rsn --noconfirm gnome-shell-extension-installer

install_nvm:
	# Installing NVM
	@bash nvm.sh

setup_gtk_theme:
	# Setup gtk theme
	# Installing dependencies
	@yay -S --noconfirm python-virtualenv
	# Removing old GTK Theme
	@rm -rf ~/.themes/Catppuccin-Mocha-Standard-Blue-*
	@rm -rf /tmp/gtk-theme
	# Cloning GTK Theme
	@git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk-theme
	# Installing build and setup GTK Theme
	@cd /tmp/gtk-theme && virtualenv -p python3 venv && source venv/bin/activate && pip install -r requirements.txt && python install.py mocha -a blue -s standard -l --tweaks rimless
	# Defining themes
	@gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Blue-Dark"
	@gsettings set org.gnome.desktop.wm.preferences theme "Catppuccin-Mocha-Standard-Blue-Dark"
	@dconf write /org/gnome/shell/extensions/user-theme/name "'Catppuccin-Mocha-Standard-Blue-Dark'"
	# Setup theme for flatpak apps
	@sudo flatpak override --filesystem=$$HOME/.themes
	@sudo flatpak override --filesystem=$$HOME/.config/gtk-3.0
	@sudo flatpak override --filesystem=$$HOME/.config/gtk-4.0
	@sudo flatpak override --env=GTK_THEME="Catppuccin-Mocha-Standard-Blue-Dark"
	# Remove dependencies
	@yay -Rsn --noconfirm python-virtualenv

setup_icon_theme:
	# Defining icons
	@papirus-folders -C cat-mocha-blue
	@gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
	@sudo flatpak override --filesystem=$$HOME/.icons

setup_wallpaper:
	# Coping wallpaper image
	@cp ./assets/wallpaper.jpg ~/.wallpaper.jpg
	# Defining wallpaper
	@gsettings set org.gnome.desktop.background picture-uri "file:///$${HOME}/.wallpaper.jpg"
	@gsettings set org.gnome.desktop.background picture-uri-dark "file:///$${HOME}/.wallpaper.jpg"
	@gsettings set org.gnome.desktop.screensaver picture-uri "file:///$${HOME}/.wallpaper.jpg"

setup_cursors:
	# Setup cursors
	# Cloning cursors
	@rm -rf /tmp/cursors
	@mkdir -p ~/.icons
	@git clone --depth=1 https://github.com/catppuccin/cursors.git /tmp/cursors
	# Installing cursors
	@unzip -oq /tmp/cursors/cursors/Catppuccin-Mocha-Light-Cursors.zip -d ~/.icons
	# Defining cursors
	@gsettings set org.gnome.desktop.interface cursor-theme "Catppuccin-Mocha-Light-Cursors"
	# Defining cursor size
	@gsettings set org.gnome.desktop.interface cursor-size 24

load_dconf:
	# Loading dconf
	@dconf load / < ./dconf

setup_discord_theme:
	# Setup discord theme
	@mkdir -p ~/.config/discocss
	@curl -L https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css > ~/.config/discocss/custom.css

look: setup_gtk_theme setup_icon_theme setup_wallpaper setup_cursors load_dconf

setup_kitty:
	# Setup kitty
	# Removing old files
	@rm -rf ~/.config/kitty
	# Coping files
	@cp -r ./kitty ~/.config/kitty

setup_bat:
	# Setup bat theme
	# Cloning theme
	@rm -rf /tmp/bat
	@git clone --depth=1 https://github.com/catppuccin/bat.git /tmp/bat
	# Coping files
	@mkdir -p "$$(bat --config-dir)/themes"
	@cp -r /tmp/bat/*.tmTheme "$$(bat --config-dir)/themes"
	@bat cache --build

copy_configs:
	# Coping config files
	# Removing old files
	@rm -rf ~/.config/flameshot
	# Coping files
	@cp -r ./flameshot ~/.config/flameshot

setup_oh_my_zsh:
	# Setup oh-my-zsh
	# Removing old files
	@rm -rf ~/.oh-my-zsh
	# Installing oh-my-zsh
	@sh -c "$$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sed 's/exec zsh -l//g')"
	# Cloning theme and plugins
	@git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
	@git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	# Removing dump files
	@rm -rf ~/.zcompdump* ~/.zshrc.* ~/.shell.pre-oh-my-zsh
	# Coping config files
	@cp ./oh-my-zsh/alias ~/.alias
	@cp ./oh-my-zsh/p10k.zsh ~/.p10k.zsh
	@cp ./oh-my-zsh/profile ~/.profile
	@cp ./oh-my-zsh/zshrc ~/.zshrc

setup_term: setup_kitty setup_oh_my_zsh setup_bat

setup_nvim:
	# Setup nvim
	# Removing old files
	@rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim 
	# Cloning AstroNvim
	@git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
	# Cloning user config
	@git clone --depth 1 https://github.com/gabrielscaranello/astronvim-config ~/.config/nvim/lua/user

update_zram:
	# Updating zram
	@echo 'zram-size=max(ram/2, 4096)' | sudo tee -a /etc/systemd/zram-generator.conf
	# Adjust swappiness
	@echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.d/00-custom.conf
	@echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.d/00-custom.conf

enable_osprober:
	# Enabling osprober
	@echo 'GRUB_DISABLE_OS_PROBER=false' | sudo tee -a /etc/default/grub
	@sudo grub-mkconfig -o /boot/grub/grub.cfg

docker_permissions:
	# Docker permissions
	@sudo usermod -aG docker $$(whoami)

hide_apps:
	# Hidding apps
	@bash hide_apps.sh

mimetypes:
	# Mimetypes
	@cp ./mimeapps.list ~/.config/mimeapps.list

enable_services:
	# Enabling services
	@sudo systemctl enable --now docker
	@sudo systemctl enable --now gdm

clean:
	# Cleaning cache
	@yay -Sccd --noconfirm
	# Removing unused packages
	@yay -Rsn $$(yay -Qqdt) --noconfirm

setup_all: 
	@$(MAKE) install_system
	@$(MAKE) install_nvm
	@$(MAKE) install_gnome_extensions
	@$(MAKE) setup_term
	@$(MAKE) install_flatpak
	@$(MAKE) setup_nvim 
	@$(MAKE) look
	@$(MAKE) update_zram
	@$(MAKE) enable_osprober
	@$(MAKE) docker_permissions
	@$(MAKE) hide_apps
	@$(MAKE) mimetypes
	@$(MAKE) copy_configs
	@$(MAKE) clean
	@$(MAKE) enable_services

