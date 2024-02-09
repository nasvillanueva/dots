#!/usr/bin/env zsh

files=(
  bin
  config/alacritty
  config/nvim
  config/ranger
  config/skhd
  config/lazygit
  local/share/nvim/site/pack/nxs
  gitconfig_global
  gitconfig
  ideavimrc
  nxs-omz
  skhdrc
  tmux.conf
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
