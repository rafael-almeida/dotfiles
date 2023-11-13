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

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

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
