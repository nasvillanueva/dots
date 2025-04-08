# Plugins
function install_plugin {
  plugin="$1"
  main_file="$2"

  plugin_dir="${plugin#*/}"
  install_dir="$NXS_ZSH_HOME/plugins/$plugin_dir"

  if [[ -d "$install_dir" ]]; then
    source "$install_dir/$main_file"
    return 0
  fi

  git clone "https://github.com/$plugin" "$install_dir"
  source "$install_dir/$main_file"
}

install_plugin "zdharma-continuum/fast-syntax-highlighting" "fast-syntax-highlighting.plugin.zsh"
install_plugin "zsh-users/zsh-autosuggestions" "zsh-autosuggestions.zsh"
install_plugin "zsh-users/zsh-completions" "zsh-completions.plugin.zsh"

unset -f install_plugin

