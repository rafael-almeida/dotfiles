#!/bin/bash

# Extension list file
EXTENSIONS_FILE="$HOME/dotfiles/vscode/extensions.txt"

# Check if extensions.txt exists
if [[ ! -f "$EXTENSIONS_FILE" ]]; then
    echo "Error: extensions.txt not found at $EXTENSIONS_FILE"
    exit 1
fi

# Check if code command is available
if ! command -v code &> /dev/null; then
    echo "Error: VSCode 'code' command not found. Install VSCode and add it to PATH."
    exit 1
fi

echo "Installing VSCode extensions..."

# Install extensions from file
while IFS= read -r extension; do
    # Skip empty lines and comments
    if [[ -n "$extension" && ! "$extension" =~ ^[[:space:]]*# ]]; then
        echo "Installing: $extension"
        code --install-extension "$extension" --force
    fi
done < "$EXTENSIONS_FILE"

echo "VSCode extensions installed successfully!"