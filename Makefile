# Makefile for fedora

add_repos:
	# Adding repos
	# Code
	@sudo rm -rf /etc/apt/sources.list.d/vscode.list /etc/apt/keyrings/packages.microsoft.gpg
	@wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	@sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	@sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	@rm -f packages.microsoft.gpg
	# Docker
	@sudo rm -rf /etc/apt/keyrings/docker.gpg /etc/apt/sources.list.d/docker.list
	@sudo install -m 0755 -d /etc/apt/keyrings
	@curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	@sudo chmod a+r /etc/apt/keyrings/docker.gpg
	@echo "deb [arch="$$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	# GDU
	@set +e; sudo add-apt-repository -r -y ppa:daniel-milde/gdu; set -e;
	@sudo add-apt-repository -y ppa:daniel-milde/gdu

update_system:
	# Add nala
	@sudo apt install -y nala
	# Install dependencies
	@sudo nala install -y wget gpg apt-transport-https ca-certificates curl gnupg
	@$(MAKE) add_repos
	# Remove unused packages
	@sudo nala purge -y $$(cat ./packages_to_remove | tr '\n' ' ')
	# Updating system
	@sudo nala update
	@sudo nala upgrade -y

install_system: update_system
	# Installing system packages
	@sudo nala install -y $$(cat ./system_packages | tr '\n' ' ')

install_flatpak:
	# Installing flatpak apps
	@flatpak install flathub --assumeyes $$(cat ./flatpak_packages | tr '\n' ' ')

install_nvm:
	# Installing NVM
	@bash ./scripts/nvm.sh

install_telegram:
	# Installing Telegram
	@bash ./scripts/telegram.sh

install_firefox:
	# Installing Firefox
	@bash ./scripts/firefox.sh

install_discord:
	# Installing Discord
	@bash ./scripts/discord.sh

install_bottom:
	# Installing Bottom
	@bash ./scripts/bottom.sh

install_lazygit:
	# Installing Lazygit
	@bash ./scripts/lazygit.sh

install_lazydocker:
	# Installing Lazydocker
	@bash ./scripts/lazydocker.sh

install_jetbrains_fonts:
	# Installing Jetbrains Fonts
	@bash ./scripts/jetbrains_fonts.sh

install_neovim:
	# Installing Neovim
	@bash ./scripts/neovim.sh

install_git_flow_cjs:
	# Installing Git flow CJS
	@wget -q  https://raw.githubusercontent.com/CJ-Systems/gitflow-cjs/develop/contrib/gitflow-installer.sh -O /tmp/gitflow-installer.sh
	@cd /tmp && sudo bash ./gitflow-installer.sh install stable

setup_gtk_theme:
	# Setup gtk theme
	@gsettings set org.gnome.desktop.interface gtk-theme "ZorinBlue-Dark"
	@gsettings set org.gnome.desktop.wm.preferences theme "ZorinBlue-Dark"
	@dconf write /org/gnome/shell/extensions/user-theme/name "'ZorinBlue-Dark'"

setup_icon_theme:
	# Defining icons
	@gsettings set org.gnome.desktop.interface icon-theme 'ZorinBlue-Dark'

setup_wallpaper:
	# Coping wallpaper image
	@cp ./assets/wallpaper.jpg ~/.wallpaper.jpg
	# Defining wallpaper
	@gsettings set org.gnome.desktop.background picture-uri "file:///$${HOME}/.wallpaper.jpg"
	@gsettings set org.gnome.desktop.background picture-uri-dark "file:///$${HOME}/.wallpaper.jpg"
	@gsettings set org.gnome.desktop.screensaver picture-uri "file:///$${HOME}/.wallpaper.jpg"

install_cursor:
	# Installing cursor
	@bash ./scripts/cursor.sh

load_dconf:
	# Loading dconf
	# @dconf load / < ./config/dconf

setup_discord_theme:
	# Setup discord theme
	@mkdir -p ~/.config/discord
	@/usr/bin/discord --start-minimized > /dev/null 2>&1 &
	# Sleep 2 seconds to wait discord start
	@sleep 2
	@curl -L https://catppuccin.github.io/discord/dist/catppuccin-mocha-blue.theme.css > ~/.config/discord/catppuccin-mocha-blue.theme.css
	@python3 -m pip install -U https://github.com/leovoel/BeautifulDiscord/archive/master.zip
	@python3 -m beautifuldiscord --css ~/.config/discord/catppuccin-mocha-blue.theme.css
	# Killing discord process
	@kill $$(pidof -s Discord)

look: setup_gtk_theme setup_icon_theme setup_wallpaper install_cursor load_dconf

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
	@mkdir -p ~/.local/bin
	@set +e; unlink ~/.local/bin/bat; set -e;
	@ln -s /usr/bin/batcat ~/.local/bin/bat
	@mkdir -p "$$(batcat --config-dir)/themes"
	@cp -r /tmp/bat/*.tmTheme "$$(batcat --config-dir)/themes"
	@batcat cache --build

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

enable_services:
	# Enabling services
	# Docker
	@sudo systemctl enable --now docker

clean:
	# Removing unused packages
	@sudo nala autopurge -y
	# Cleaning cache
	@sudo nala clean

setup_all: 
	@$(MAKE) install_system
	@$(MAKE) install_nvm
	@$(MAKE) install_flatpak
	@$(MAKE) install_telegram
	@$(MAKE) install_discord
	@$(MAKE) install_bottom
	@$(MAKE) install_lazygit
	@$(MAKE) install_lazydocker
	@$(MAKE) install_neovim
	@$(MAKE) install_jetbrains_fonts
	@$(MAKE) install_git_flow_cjs
	@$(MAKE) setup_term
	@$(MAKE) setup_nvim
	@$(MAKE) look
	@$(MAKE) update_swap
	@$(MAKE) docker_permissions
	@$(MAKE) copy_configs
	@$(MAKE) clean
	@$(MAKE) enable_services

