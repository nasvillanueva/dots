# globals
NXS_ZSH_HOME="$HOME/.config/zsh"

# Theme
PROMPT='%B%(?.%F{blue}>.%F{red}>)%f%b '

# Plugins
function install_plugin {
  plugin="$1"
  main_file="$2"

  plugin_dir="${plugin#*/}"
  install_dir="$NXS_ZSH_HOME/$plugin_dir"

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

# Completions
autoload -Uz compinit
compinit

eval "$(fzf --zsh)"

# User Config

source $REMETIS_PATH/remetis_aliases.sh

alias vim=$(which nvim)

set -o emacs

alias lg="lazygit"
alias ldock="lazydocker"
alias ls="eza --icons --group-directories-first"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
