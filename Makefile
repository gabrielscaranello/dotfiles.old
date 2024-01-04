# Makefile for arch - KDE Plasma

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

install_steam:
	# Install packages from AMD
	@yay -S --noconfirm $$(cat ./steam_packages | tr '\n', ' ')

install_nvidia:
	# Install packages from NVidia
	# Install packages
	@yay -S --noconfirm $$(cat ./nvidia_packages | tr '\n', ' ')
	# enable services
	@sudo systemctl enable switcheroo-control.service

install_nvm:
	# Installing NVM
	@bash ./scripts/nvm.sh

install_telegram:
	# Installing Telegram
	@bash ./scripts/telegram.sh

setup_look_files:
	# Coping wallpaper image
	@mkdir -p ~/.local/share/wallpapers
	@cp ./assets/wallpaper.png ~/.local/share/wallpapers/default.png

install_cursors:
	# Setup cursors
	@bash ./scripts/cursor.sh

look: install_cursors setup_look_files

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

setup_kitty:
	# Setup kitty
	# Removing old files
	@rm -rf ~/.config/kitty
	# Coping files
	@cp -r ./config/kitty ~/.config/kitty

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

enable_services:
	# Enabling services
	@sudo systemctl enable bluetooth.service
	@sudo systemctl enable cronie.service
	@sudo systemctl enable cups
	@sudo systemctl enable docker
	@sudo systemctl enable sddm
	@sudo systemctl enable power-profiles-daemon.service

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
	@$(MAKE) look
	@$(MAKE) update_swap
	@$(MAKE) docker_permissions
	@$(MAKE) hide_apps
	@$(MAKE) copy_configs
	@$(MAKE) clean
	@$(MAKE) enable_services

