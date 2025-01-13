export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="nxs"
ZSH_CUSTOM=$HOME/.nxs-omz

plugins=(git fast-syntax-highlighting zsh-autosuggestions zsh-completions)

# Completions
autoload -Uz compinit
compinit

path+=$ZSH_CUSTOM/plugins/zsh-completions/src
autoload bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/az

source $ZSH/oh-my-zsh.sh

eval "$(fzf --zsh)"

# User Config

function nvim_on_exit() {
  if [[ ! -z $NVIM ]] && [[ $- == *i* ]]; then
    nvim --server $NVIM --remote-send "<c-\\><c-n>:lua RESTORE_TERM_WINDOW_BUFFER(); print(' ')<cr>i"
  fi
}

zshexit_functions=(${zshexit_functions[@]} "nvim_on_exit")

rms() {
  (cd "$REMETIS_PATH" && $REMETIS_PATH/command/bin/remetis_server "$@")
}

alias rmy='rms yarn'
alias rml='rms logs'
alias rmn='rms npm'
alias vim=$(which nvim)

alias lg="lazygit"
alias ls="eza --icons --group-directories-first"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
