# dotfiles

```sh
:PackerInstall
:PackerCompile
:TSUpdate
:TSInstall vim
```

## Generate SSH Key

Start the ssh-agent in the background

```
eval "$(ssh-agent -s)"
```

Create `~/.ssh/config`

```
touch ~/.ssh/config
```

Attach to `~/.ssh/config`

```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

Add your SSH private key to the ssh-agent, storing the passphrase in the keychain

```
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```
