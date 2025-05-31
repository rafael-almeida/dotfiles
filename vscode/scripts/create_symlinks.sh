#!/bin/bash

# VSCode user directory
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
DOTFILES_VSCODE="$HOME/dotfiles/vscode"

# Create VSCode user directory if it doesn't exist
mkdir -p "$VSCODE_USER_DIR"

# Function to create versioned backup
backup_file() {
    local file="$1"
    if [[ -e "$file" ]]; then
        local backup="$file.bak"
        local counter=1
        
        while [[ -e "$backup" ]]; do
            backup="$file.bak.$counter"
            ((counter++))
        done
        
        mv "$file" "$backup"
        echo "Backed up: $file -> $backup"
    fi
}

# Backup existing files/links
backup_file "$VSCODE_USER_DIR/settings.json"
backup_file "$VSCODE_USER_DIR/keybindings.json"
backup_file "$VSCODE_USER_DIR/snippets"

# Create symlinks
ln -s "$DOTFILES_VSCODE/settings.json" "$VSCODE_USER_DIR/settings.json"
ln -s "$DOTFILES_VSCODE/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
ln -s "$DOTFILES_VSCODE/snippets" "$VSCODE_USER_DIR/snippets"

echo "VSCode dotfiles linked successfully!"