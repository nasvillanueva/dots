#!/usr/bin/env zsh

files=(bin zshrc nxs-omz tmux.conf zshenv config/nvim config/ranger config/alacritty gitconfig_global ideavimrc skhdrc)

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
