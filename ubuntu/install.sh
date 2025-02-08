#!/usr/bin/env bash

sudo apt update
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y software-properties-common build-essential cmake \
    zip unzip curl ansible

# SSH setup
sudo cp -r ../.ssh/ $HOME/.ssh
sudo ansible-vault decrypt $HOME/.ssh/id_ed25519
eval $(ssh-agent -s)
ssh-add $HOME/.ssh/id_ed25519

# ZSH setup
sudo apt install -y zsh
sudo chsh -s $(which zsh)
# Zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.zsh/zsh-autosuggestions
# Starship
sudo curl -sS https://starship.rs/install.sh | sh -s -- -y

# Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash 
source $HOME/.zshrc
nvm install 20
curl -fsSL https://bun.sh/install | bash

# Golang
sudo curl -Lo golang.tar.gz "https://go.dev/dl/go1.23.2.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf golang.tar.gz
sudo rm -rf golang.tar.gz

# PHP
/bin/bash -c "$(curl -fsSL https://php.new/install/linux/8.4)"

# Dotfiles
sudo apt install -y stow
git clone --recurse-submodules git@personal:cjcounsell/.dotfiles.git $HOME/.dotfiles
rm $HOME/.zshrc
pushd $HOME/.dotfiles
stow -R bin -R git -R nvim -R ssh -R starship -R tmux -R zsh
popd

# Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
sudo curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
sudo rm -rf lazygit.tar.gz lazygit

# Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Neovim
curl -LO https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo rm -rf nvim-linux-x86_64.tar.gz

# Libs
sudo apt install -y fzf tmux ripgrep fd-find ani-cli jq httpie eza bat

# Tmux
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
$HOME/.tmux/plugins/tpm/tpm

