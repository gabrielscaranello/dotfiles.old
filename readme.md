# Gabriel Scaranello - dotfiles

> My intention is to group all my settings in one place and share it with the community 

### Neovim
- [Neovim website](https://neovim.io)  

```sh
mkdir -p ~/.config/nvim
cp -r ./nvim/* ~/.config/nvim
```
Open nvim and run `:PlugInstall`


### Oh my zsh
Install zsh, oh my zsh and this plugins.
An Nerd Font is needed, I chose the Fira Code  
- [Oh my zsh website](https://ohmyz.sh)  
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k#oh-my-zsh)  
- [Zsh autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)  
- [Fira Code Nerd Font](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf)  

```sh
cp -r ./zsh/* ~/
exec $SHELL
```


