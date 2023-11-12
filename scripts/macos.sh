defaults write -g ApplePressAndHoldEnabled -bool false

# ohmyzsh ---------------------------------------------------------------------

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# -----------------------------------------------------------------------------

python3 -m pip install --upgrade pip
mkdir ~/.virtualenvs

# -----------------------------------------------------------------------------

brew update

brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-fira-code-nerd-font

brew tap homebrew/cask-drivers
brew install --cask qmk-toolbox

brew install --cask firefox
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask rectangle
brew install --cask libreoffice
brew install --cask gimp
brew install --cask vlc
brew install --cask ngrok
brew install --cask raindropio
brew install --cask protonvpn
brew install --cask spotify
brew install --cask authy
brew install --cask whatsapp
brew install --cask discord
brew install --cask qbittorrent
brew install --cask zoom
brew install --cask figma
brew install --cask notion
brew install --cask iterm2
brew install --cask kitty
brew install --cask visual-studio-code
brew install --cask gitkraken
brew install --cask stoplight-studio
brew install --cask nosql-workbench
brew install --cask insomnia

brew install qmk/qmk/qmk
brew install zsh
brew install tree
brew install tmux
brew install git
brew install pandoc
brew install graphviz
brew install watchexec
brew install docker
brew install neovim
brew install hugo
brew install awscli
brew install aws-sam-cli
brew install pipenv
brew install node
brew install pnpm
brew install typescript
brew install go
brew install gopls
brew install lua

brew install postgresql@16
brew install --cask pgadmin4

# neovim
# -----------------------------------------------------------------------------

python3 -m venv ~/.virtualenvs/neovim
~/.virtualenvs/neovim/bin/python -m pip install neovim

# TODO
# brew install perl

npm install -g neovim

# packer
git clone --depth 1 git@github.com:wbthomason/packer.nvim.git ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# mason
brew install --cask powershell
brew install wget
brew install rust
brew install luarocks
brew install php
brew install composer
brew install julia
brew install java
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# telescope
brew install ripgrep
brew install fd

# dap-python
python3 -m venv ~/.virtualenvs/debugpy
~/.virtualenvs/debugpy/bin/python -m pip install debugpy

# vimwiki
mkdir ~/vimwiki

# -----------------------------------------------------------------------------

ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/nvim ~/.config/nvim

cp ~/dotfiles/zsh/.zshrc_private.example ~/dotfiles/zsh/.zshrc_private
ln -s ~/dotfiles/zsh/.zshrc_private ~/
