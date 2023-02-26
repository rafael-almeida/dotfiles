brew tap homebrew/cask

brew tap homebrew/cask-fonts
brew install --cask font-fira-code
brew install --cask font-fira-code-nerd-font

brew install --cask visual-studio-code
brew install --cask firefox
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask rectangle
brew install --cask vlc
brew install --cask whatsapp
brew install --cask spotify
brew install --cask raindropio
brew install --cask authy

brew install --cask iterm2
brew install --cask kitty

brew install --cask postman
brew install --cask stoplight-studio
brew install --cask nosql-workbench

# brew install --cask openoffice
brew install --cask libreoffice
brew install --cask gimp
brew install --cask freecad

# qmk
brew tap homebrew/cask-drivers
brew install --cask qmk-toolbox
brew install qmk/qmk/qmk

brew install zsh
brew install tree
brew install exiftool
brew install tmux

brew install git
brew install docker
brew install awscli
brew install aws-sam-cli

brew install typescript
brew install node
brew install pnpm

brew install go
brew install gopls

python3 -m pip install --upgrade pip
brew install pipenv

# NEOVIM
# -----------------------------------------------------------------------------


brew install neovim
brew install --cask powershell
brew install wget
brew install ripgrep
brew install fd
brew install lua
brew install luarocks
brew install rust
brew install julia
brew install php
brew install composer
brew install perl
brew install java
brew install javac

sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

npm install -g neovim

mkdir ~/.virtualenvs
python3 -m venv ~/.virtualenvs/neovim
~/.virtualenvs/neovim/bin/python -m pip install neovim

git clone --depth 1 git@github.com:wbthomason/packer.nvim.git ~/.local/share/nvim/site/pack/packer/start/packer.nvim

python3 -m venv ~/.virtualenvs/debugpy
~/.virtualenvs/debugpy/bin/python -m pip install debugpy

mkdir ~/vimwiki

# -----------------------------------------------------------------------------

defaults write -g ApplePressAndHoldEnabled -bool false

ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/nvim ~/.config/nvim

cp ~/dotfiles/zsh/.zshrc_private ~/
