export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="nxs"
ZSH_CUSTOM=$HOME/.nxs-omz

plugins=(git fast-syntax-highlighting zsh-autosuggestions zsh-completions)

# Completions
fpath+=$ZSH_CUSTOM/plugins/zsh-completions/src

source $ZSH/oh-my-zsh.sh

# User Config

alias rms='remetis_server'
alias rmy='rms yarn'
alias rml='rms logs'
alias rmn='rms npm'
alias vim=$(which nvim)

alias lg="lazygit"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
