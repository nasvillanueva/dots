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

alias rms='remetis_server'
alias rmy='rms yarn'
alias rml='rms logs'
alias rmn='rms npm'
alias vim=$(which nvim)

alias lg="lazygit"
alias ls="exa --icons --group-directories-first"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
