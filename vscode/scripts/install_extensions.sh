#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSIONS_FILE="$SCRIPT_DIR/extensions.txt"

if [ -f "$EXTENSIONS_FILE" ]; then
  echo "Installing VSCode extensions..."
  cat "$EXTENSIONS_FILE" | while read extension || [[ -n $extension ]];
  do
    code --install-extension "$extension" --force
  done
  echo "VSCode extensions installation complete."
else
  echo "Extensions file not found: $EXTENSIONS_FILE"
fi