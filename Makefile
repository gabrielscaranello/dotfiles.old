# Makefile for arch cinnamon

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

install_nvidia:
	# Install packages from NVidia
	# Install packages
	@yay -S $$(cat ./nvidia_packages | tr '\n', ' ')
	# enable services
	@sudo systemctl enable --now switcheroo-control.service
	@sudo envycontrol -s nvidia

install_steam:
	# Install packages from Steam
	@yay -S --noconfirm $$(cat ./steam_packages | tr '\n', ' ')

install_nvm:
	# Installing NVM
	@bash ./scripts/nvm.sh

install_telegram:
	# Installing Telegram
	@bash ./scripts/telegram.sh

setup_gtk_theme:
	# Setup gtk theme
	# Removing old GTK Theme
	@sudo rm -rf /usr/share/themes/Catppuccin-Mocha-Standard-Blue-*
	@rm -rf ~/.themes/Catppuccin-Mocha-Standard-Blue-*
	@rm -rf /tmp/gtk-theme
	@rm -rf ~/.config/gtk-4.0
	# Cloning GTK Theme
	@git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk-theme
	# Installing build and setup GTK Theme
	@bash -c "cd /tmp/gtk-theme && virtualenv -p python3 venv && source venv/bin/activate && pip install -r requirements.txt && python install.py mocha -a blue -s standard -l --tweaks rimless"
	# Copy to system
	@sudo cp -r ~/.themes/Catppuccin-Mocha-Standard-Blue-* /usr/share/themes
	# Defining themes
	@gsettings set org.cinnamon.theme name "Catppuccin-Mocha-Standard-Blue-Dark"
	@gsettings set org.cinnamon.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Blue-Dark"
	@gsettings set org.cinnamon.desktop.wm.preferences theme "Catppuccin-Mocha-Standard-Blue-Dark"

setup_icon_theme:
	# Defining icons
	@papirus-folders -C cat-mocha-blue
	@gsettings set org.cinnamon.desktop.interface icon-theme "Papirus-Dark"

setup_wallpaper:
	# Coping wallpaper image
	@sudo mkdir -p /usr/share/backgrounds/user
	@sudo cp ./assets/wallpaper.png /usr/share/backgrounds/user/wallpaper.png
	# Defining wallpaper
	@gsettings set org.cinnamon.desktop.background picture-uri "file:////usr/share/backgrounds/user/wallpaper.png"

setup_cursors:
	# Setup cursors
	# Cloning cursors
	@rm -rf /tmp/cursors
	@sudo rm -rf /usr/share/icons/Catppuccin*
	@rm -rf ~/.icons/Catppuccin-Mocha-Light-Cursors
	@mkdir -p ~/.icons
	@git clone --depth=1 https://github.com/catppuccin/cursors.git /tmp/cursors
	# Installing cursors
	@unzip -oq /tmp/cursors/cursors/Catppuccin-Mocha-Light-Cursors.zip -d ~/.icons
	# Copy to system
	@sudo cp -r ~/.icons/Catppuccin-Mocha-Light-Cursors /usr/share/icons/Catppuccin-Mocha-Light-Cursors
	# Defining cursors
	@gsettings set org.cinnamon.desktop.interface cursor-theme "Catppuccin-Mocha-Light-Cursors"
	# Defining cursor size
	@gsettings set org.cinnamon.desktop.interface cursor-size 24

load_dconf:
	# Loading dconf
	@dconf load / < ./config/dconf

setup_discord_theme:
	# Setup discord theme
	@mkdir -p ~/.config/discord
	@/usr/bin/discord --start-minimized > /dev/null 2>&1 &
	# Sleep 2 seconds to wait discord start
	@sleep 2
	@curl -L https://catppuccin.github.io/discord/dist/catppuccin-mocha-blue.theme.css > ~/.config/discord/catppuccin-mocha-blue.theme.css
	@PIP_BREAK_SYSTEM_PACKAGES=1 python3 -m pip install -U https://github.com/leovoel/BeautifulDiscord/archive/master.zip
	@python3 -m beautifuldiscord --css ~/.config/discord/catppuccin-mocha-blue.theme.css
	# Killing discord process
	@kill $$(pidof -s Discord)

look: setup_gtk_theme setup_icon_theme setup_wallpaper setup_cursors load_dconf 

setup_kitty:
	# Setup kitty
	# Removing old files
	@rm -rf ~/.config/kitty
	# Coping files
	@cp -r ./config/kitty ~/.config/kitty

setup_bat:
	# Setup bat theme
	# Download theme
	@mkdir -p "$$(bat --config-dir)/themes"
	@wget -P "$$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
	# Update cache
	@bat cache --build

copy_configs:
	# Coping config files
	@bash ./scripts/configs.sh

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
	@cp ./config/oh-my-zsh/alias ~/.alias
	@cp ./config/oh-my-zsh/p10k.zsh ~/.p10k.zsh
	@cp ./config/oh-my-zsh/profile ~/.profile
	@cp ./config/oh-my-zsh/zshrc ~/.zshrc

setup_term: setup_kitty setup_oh_my_zsh setup_bat

setup_cinnamon:
	# Setup cinnamon
	@bash ./scripts/cinnamon.sh

setup_nvim:
	# Setup nvim
	# Removing old files
	@rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim 
	# Cloning AstroNvim
	@git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
	# Cloning user config
	@git clone --depth 1 https://github.com/gabrielscaranello/astronvim-config ~/.config/nvim/lua/user

update_swap:
	# Add swapfile
	@bash ./scripts/swap.sh

docker_permissions:
	# Docker permissions
	@sudo usermod -aG docker $$(whoami)

hide_apps:
	# Hidding apps
	@bash ./scripts/hide_apps.sh

mimetypes:
	# Mimetypes
	@cp ./config/mimeapps.list ~/.config/mimeapps.list

enable_services:
	# Enabling services
	@sudo systemctl enable bluetooth
	@sudo systemctl enable cups
	@sudo systemctl enable docker
	@sudo systemctl enable lightdm
	@sudo systemctl enable power-profiles-daemon.service
	@sudo systemctl enable touchegg

clean:
	# Cleaning cache
	@yay -Sccd --noconfirm
	# Removing unused packages
	@yay -Rsn $$(yay -Qqdt) --noconfirm

setup_all: 
	@$(MAKE) install_system
	@$(MAKE) install_nvm
	@$(MAKE) setup_term
	@$(MAKE) install_telegram
	@$(MAKE) setup_nvim 
	@$(MAKE) setup_cinnamon
	@$(MAKE) look
	@$(MAKE) copy_configs
	@$(MAKE) update_swap
	@$(MAKE) docker_permissions
	@$(MAKE) hide_apps
	@$(MAKE) mimetypes
	@$(MAKE) clean
	@$(MAKE) enable_services

