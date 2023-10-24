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

. /opt/homebrew/opt/asdf/libexec/asdf.sh
