# ---------------------------------------
# Oh My Zsh Configuration
# ---------------------------------------

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# ---------------------------------------
# Environment Variables
# ---------------------------------------

export XDG_CONFIG_HOME="$HOME/.config"

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Mason.nvim
export PATH="$HOME/.local/share/nvim/mason/bin/:$PATH"

# Go
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:$PATH"

# Flutter
export PATH=$HOME/.gem/bin:$PATH

# Set Pipenv to create venv at the project root
PIPENV_VENV_IN_PROJECT=1

# ---------------------------------------
# iTerm and Tmux Integration
# ---------------------------------------

# Automatically attach to a tmux session when opening iTerm
if [[ $TERM_PROGRAM == "iTerm.app" ]]; then
  tmux attach || tmux new
fi

# ---------------------------------------
# Aliases
# ---------------------------------------

alias v=nvim
alias dt="cd ~/dotfiles && nvim ."

# ---------------------------------------
# Custom/Private Configurations
# ---------------------------------------

# Source private zsh configurations, if available
[[ -f ~/.zshrc_private ]] && source ~/.zshrc_private
export HOMEBREW_NO_AUTO_UPDATE=1

# Created by `pipx` on 2024-07-07 04:29:38
export PATH="$PATH:/Users/rafael/.local/bin"
if [ -f "/Users/rafael/.config/fabric/fabric-bootstrap.inc" ]; then . "/Users/rafael/.config/fabric/fabric-bootstrap.inc"; fi

# bun completions
[ -s "/Users/rafael/.bun/_bun" ] && source "/Users/rafael/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
