#!/usr/bin/env zsh

files=(
  bin
  config/nvim
  config/skhd
  config/lazygit
  config/ghostty
  config/zsh
  curlrc
  gitconfig_global
  gitconfig
  hushlogin
  skhdrc
  tmux.conf
  zimrc
  zshenv
  zshrc
)

for f in $files; do
  dest="$HOME/.$f"

  if [[ -L "$dest" ]]; then
    unlink "$dest"
  elif [[ -f "$dest" || -d "$dest" ]]; then
    echo "Failed to symlink $dest; Non-symlinked file/dir exists"
    continue
  fi

  ln -s "$PWD/$f" "$dest"
done
