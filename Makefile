# Makefile for fedora

add_repos:
	# Adding repos
	# Code
	@sudo rm -rf /etc/apt/sources.list.d/vscode.list /etc/apt/keyrings/packages.microsoft.gpg
	@wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	@sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
	@sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
	@rm -f packages.microsoft.gpg
	# Onlyoffice
	@sudo rm -rf /usr/share/keyrings/onlyoffice.gpg /etc/apt/sources.list.d/onlyoffice.list
	@mkdir -p -m 700 ~/.gnupg
	@gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
	@chmod 644 /tmp/onlyoffice.gpg
	@sudo chown root:root /tmp/onlyoffice.gpg
	@sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg
	@echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list
	# Docker
	@sudo rm -rf /etc/apt/keyrings/docker.gpg /etc/apt/sources.list.d/docker.list
	@sudo install -m 0755 -d /etc/apt/keyrings
	@curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	@sudo chmod a+r /etc/apt/keyrings/docker.gpg
	@echo "deb [arch="$$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	# GDU
	@set +e; sudo add-apt-repository -r -y ppa:daniel-milde/gdu; set -e;
	@sudo add-apt-repository -y ppa:daniel-milde/gdu
	# Papirus icon theme
	@set +e; sudo add-apt-repository -r -y ppa:papirus/papirus; set -e;
	@sudo add-apt-repository -y ppa:papirus/papirus
	# Neovim
	@set +e; sudo add-apt-repository -r -y ppa:neovim-ppa/unstable; set -e;
	@sudo add-apt-repository -y ppa:neovim-ppa/unstable
	# Golang
	@set +e; sudo add-apt-repository -r -y ppa:longsleep/golang-backports; set -e;
	@sudo add-apt-repository -y ppa:longsleep/golang-backports

update_system:
	# Add nala
	@sudo apt install -y nala
	# Install dependencies
	@sudo nala install -y wget gpg apt-transport-https ca-certificates curl gnupg
	@$(MAKE) add_repos
	# Remove unused packages
	@sudo nala purge -y $$(cat ./packages_to_remove | tr '\n' ' ')
	# Updating system
	@sudo nala upgrade -y

install_system: update_system
	# Installing system packages
	@sudo nala install -y $$(cat ./system_packages | tr '\n' ' ')

install_nvm:
	# Installing NVM
	@bash ./scripts/nvm.sh

install_telegram:
	# Installing Telegram
	@bash ./scripts/telegram.sh

install_discord:
	# Installing Discord
	@bash ./scripts/discord.sh

install_dbeaver:
	# Installing DBeaver
	@bash ./scripts/dbeaver.sh

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

install_git_flow_cjs:
	# Installing Git flow CJS
	@wget -q  https://raw.githubusercontent.com/CJ-Systems/gitflow-cjs/develop/contrib/gitflow-installer.sh -O /tmp/gitflow-installer.sh
	@cd /tmp && sudo bash ./gitflow-installer.sh install stable

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
	# Cloning catppuccin papirus folders
	@rm -rf /tmp/catppuccin-papirus-folders
	@git clone https://github.com/catppuccin/papirus-folders.git /tmp/catppuccin-papirus-folders
	# Installing catppuccin papirus folders
	@bash -c "cd /tmp/catppuccin-papirus-folders && sudo cp -r src/* /usr/share/icons/Papirus && sudo make install"
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

look: setup_gtk_theme setup_icon_theme setup_wallpaper setup_cursors load_dconf

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

enable_services:
	# Enabling services
	# Docker
	@sudo systemctl enable --now docker
	# Plank
	@plank > /dev/null 2>&1 &

purge_xterm:
	# Purging xterm
	@sudo nala purge -y xterm*

clean:
	# Removing unused packages
	@sudo nala autopurge -y
	# Cleaning cache
	@sudo nala clean

setup_all: 
	@$(MAKE) install_system
	@$(MAKE) install_nvm
	@$(MAKE) install_telegram
	@$(MAKE) install_discord
	@$(MAKE) install_bottom
	@$(MAKE) install_lazygit
	@$(MAKE) install_lazydocker
	@$(MAKE) install_jetbrains_fonts
	@$(MAKE) install_git_flow_cjs
	@$(MAKE) setup_term
	@$(MAKE) setup_cinnamon
	@$(MAKE) setup_nvim
	@$(MAKE) look
	@$(MAKE) update_swap
	@$(MAKE) docker_permissions
	@$(MAKE) copy_configs
	@$(MAKE) purge_xterm
	@$(MAKE) clean
	@$(MAKE) enable_services

