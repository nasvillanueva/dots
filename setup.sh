#!/usr/bin/env zsh

files=(
  bin
  config/nvim
  config/skhd
  config/lazygit
  config/wezterm
  config/zsh
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
