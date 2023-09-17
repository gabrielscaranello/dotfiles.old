# Makefile for fedora

add_repos:
	# Adding repos
	# RPM Fusion
	@sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$$(rpm -E %fedora).noarch.rpm
	# VSCode
	@sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	@sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	# Bottom
	@sudo dnf copr enable atim/bottom -y
	# Lazygit
	@sudo dnf copr enable atim/lazygit -y
	# Lazydocker
	@sudo dnf copr enable atim/lazydocker -y
	# Docker
	@sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

remove_unused_repos:
	# Removing unused repos
	@sudo rm -rf $$(cat ./repos_to_remove | tr '\n' ' ')

update_system: remove_unused_repos
	# Remove old packages
	@sudo dnf remove -y $$(cat ./packages_to_remove | tr '\n' ' ')
	# Updating system
	@sudo dnf update -y

install_system: update_system add_repos
	# Installing system packages
	@sudo dnf install -y $$(cat ./system_packages | tr '\n' ' ')

install_multimedia_codecs:
	# Installing multimedia codecs
	@sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
	@sudo dnf install -y lame\* --exclude=lame-devel

install_flatpak:
	# Installing flatpak
	# Add flathub repo
	@set +e; sudo flatpak remote-delete flathub; set -e;
	@sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	# Installing flatpak apps
	@flatpak install flathub --assumeyes $$(cat ./flatpak_packages | tr '\n' ' ')

install_gnome_extensions:
	# Installing gnome extensions
	# Intalling helper
	@wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
	@chmod +x gnome-shell-extension-installer
	@sudo mv gnome-shell-extension-installer /usr/bin/
	# Installing extensions
	@for i in $$(sed "s/[^0-9]//g" ./gnome_extensions); do gnome-shell-extension-installer --yes "$$i"; done

install_nvm:
	# Installing NVM
	@bash ./scripts/nvm.sh

install_telegram:
	# Installing Telegram
	@bash ./scripts/telegram.sh

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
	@rm -rf ~/.themes/Catppuccin-Mocha-Standard-Blue-*
	@rm -rf /tmp/gtk-theme
	# Cloning GTK Theme
	@git clone --recurse-submodules https://github.com/catppuccin/gtk.git /tmp/gtk-theme
	# Installing build and setup GTK Theme
	@bash -c "cd /tmp/gtk-theme && virtualenv -p python3 venv && source venv/bin/activate && pip install -r requirements.txt && python install.py mocha -a blue -s standard -l --tweaks rimless"
	# Defining themes
	@gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-Blue-Dark"
	@gsettings set org.gnome.desktop.wm.preferences theme "Catppuccin-Mocha-Standard-Blue-Dark"
	@dconf write /org/gnome/shell/extensions/user-theme/name "'Catppuccin-Mocha-Standard-Blue-Dark'"
	# Setup theme for flatpak apps
	@sudo flatpak override --filesystem=$$HOME/.themes
	@sudo flatpak override --filesystem=$$HOME/.config/gtk-3.0
	@sudo flatpak override --filesystem=$$HOME/.config/gtk-4.0
	@sudo flatpak override --env=GTK_THEME="Catppuccin-Mocha-Standard-Blue-Dark"

setup_icon_theme:
	# Defining icons
	# Cloning catppuccin papirus folders
	@rm -rf /tmp/catppuccin-papirus-folders
	@git clone https://github.com/catppuccin/papirus-folders.git /tmp/catppuccin-papirus-folders
	# Installing catppuccin papirus folders
	@bash -c "cd /tmp/catppuccin-papirus-folders && sudo cp -r src/* /usr/share/icons/Papirus && sudo make install"
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
	@dconf load / < ./config/dconf

sync_clock:
	# Sync clock 
	@sudo timedatectl set-local-rtc 0
	@sudo hwclock --systohc

setup_discord_theme:
	# Setup discord theme
	@/usr/bin/Discord --start-minimized > /dev/null 2>&1 &
	@mkdir -p ~/.config/discord
	@curl -L https://catppuccin.github.io/discord/dist/catppuccin-mocha-blue.theme.css > ~/.config/discord/catppuccin-mocha-blue.theme.css
	@python3 -m pip install -U https://github.com/leovoel/BeautifulDiscord/archive/master.zip
	@python3 -m beautifuldiscord --css ~/.config/discord/catppuccin-mocha-blue.theme.css
	# Killing discord process
	@kill $$(pidof -s Discord)

look: setup_gtk_theme setup_icon_theme setup_wallpaper setup_cursors load_dconf setup_discord_theme

setup_kitty:
	# Setup kitty
	# Removing old files
	@rm -rf ~/.config/kitty
	# Coping files
	@cp -r ./config/kitty ~/.config/kitty
	# Set kitty as default terminal
	@sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $$(which kitty) 50
	@sudo update-alternatives --set x-terminal-emulator $$(which kitty)

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
	@sudo rm -rf ~/.config/flameshot /etc/timeshift/timeshift.json
	# Coping files
	@cp -r ./config/flameshot ~/.config/flameshot
	@sudo cp ./config/timeshift.json /etc/timeshift/timeshift.json

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

update_zram:
	# Updating zram
	@echo 'zram-size=max(ram/2, 4096)' | sudo tee -a /etc/systemd/zram-generator.conf
	# Adjust swappiness
	@echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.d/00-custom.conf
	@echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.d/00-custom.conf

docker_permissions:
	# Docker permissions
	@sudo usermod -aG docker $$(whoami)

hide_apps:
	# Hidding apps
	@bash ./scripts/hide_apps.sh

enable_services:
	# Enabling services
	# Docker
	@sudo systemctl enable --now docker
	# Numlock
	@sudo sed -i 's/exit 0/if [ -x \/usr\/bin\/numlockx ]; then \/usr\/bin\/numlockx on; fi;\n\nexit 0/g' /etc/gdm/Init/Default

clean:
	# Removing unused packages
	@sudo dnf autoremove -y
	# Cleaning cache
	@sudo dnf clean all

setup_all: 
	@$(MAKE) install_system
	@$(MAKE) install_multimedia_codecs
	@$(MAKE) install_nvm
	@$(MAKE) install_flatpak
	@$(MAKE) install_telegram
	@$(MAKE) install_jetbrains_fonts
	@$(MAKE) install_git_flow_cjs
	@$(MAKE) setup_term
	@$(MAKE) setup_nvim 
	@$(MAKE) install_gnome_extensions
	@$(MAKE) look
	@$(MAKE) update_zram
	@$(MAKE) docker_permissions
	@$(MAKE) hide_apps
	@$(MAKE) copy_configs
	@$(MAKE) sync_clock
	@$(MAKE) clean
	@$(MAKE) enable_services

