# VSCode Configuration

This folder stores my Visual Studio Code settings and extensions list.

## Key Files

- **`settings.json`**: Custom editor settings.
- **`snippets/`**: Custom code snippets.
- **`extensions.txt`**: A list of my preferred extensions.
- **`scripts/`**: Installation scripts.

## Commands

```bash
cd ~/dotfiles/vscode
```

**Link Configuration Files:**

```bash
VSCODE_USER="$HOME/Library/Application Support/Code/User"
ln -sf "$PWD/settings.json" "$VSCODE_USER/settings.json"
ln -sf "$PWD/snippets" "$VSCODE_USER/snippets"
```

**Install Extensions:**

```bash
while read extension; do code --install-extension "$extension" --force; done < extensions.txt
```

**Update Extensions List:**

```bash
code --list-extensions > extensions.txt
```
