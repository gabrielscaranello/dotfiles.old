#! /bin/sh

Clone Oh My Zsh plugins and theme
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Remove old config files
[[ ! -f ~/.p10k.zsh ]] || rm -rf ~/.p10k.zsh
[[ ! -f ~/.profile ]] || rm -rf ~/.profile
[[ ! -f ~/.zshrc ]] || rm -rf ~/.zshrc

cp ./zsh/.p10k.zsh ~/.p10k.zsh
cp ./zsh/.profile ~/.profile
cp ./zsh/.zshrc ~/.zshrc

source ~/.zshrc