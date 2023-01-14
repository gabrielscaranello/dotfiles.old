#! /bin/sh

# Auxiliar DIRS
PWD=$(pwd)
ZSH_DIR="zsh"
BKP_DIR="$HOME/profile-bkp"
OMZ_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
PLUGINS_DIR="$OMZ_DIR/plugins"
THEMES_DIR="$OMZ_DIR/themes"

# Profile files
FILES=(.p10k.zsh .profile .zshrc)

# Plugins 
PLUGINS=(zsh-users/zsh-autosuggestions)

# Themes
THEMES=(romkatv/powerlevel10k) 

clone() {
  repo=$1
  path=$2

  if [[ ! -d "$path" ]]; then
    git clone "https://github.com/$repo" "$path"
  else
    echo "$repo are installed, skipping..."
  fi
}

install_plugins_and_themes() {
  for plugin in ${PLUGINS[@]}; do clone "$plugin" "${PLUGINS_DIR}/$(echo "$plugin" | cut -d'/' -f2)"; done
  for theme in ${THEMES[@]}; do clone "$theme" "${THEMES_DIR}/$(echo "$theme" | cut -d'/' -f2)"; done
}

backup_and_copy_files() {
  # make backup dir
  mkdir -p "$BKP_DIR"

  # replace files
  cd "$ZSH_DIR"

  for file in ${FILES[@]}; do
    # backup file
    [[ ! -f "$HOME/$file" ]] || mv "$HOME/$file" "$BKP_DIR/$file"
    
    # copy a new file
    cp "$file" "$HOME/$file"
  done

  cd "$PWD"
}

main() {
  echo $'\nProfile setup started\n'
  echo "Cloning plugins and themes..."
  install_plugins_and_themes
  echo $'\nCnsoping files...\n'
  backup_and_copy_files
  echo "Install completed. Old profile files is on $BKP_DIR."
}

main

