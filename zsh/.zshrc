export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git 
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

source ~/.zshrc_private

if [[ $TERM_PROGRAM == "iTerm.app" ]]; then
  tmux attach || tmux new
fi

alias v=nvim
alias dt="cd ~/dotfiles && nvim ."

# pnpm
export PNPM_HOME="/Users/rafael/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
