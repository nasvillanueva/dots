#!/usr/bin/env zsh

files=(zshrc nxs-omz tmux.conf zshenv config/nvim gitconfig_global)


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
