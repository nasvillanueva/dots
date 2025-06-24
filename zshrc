source $NXS_ZSH_HOME/nxs.zsh

[ -s "$HOME/.zshrc_work" ] && source "$HOME/.zshrc_work"

source <(fzf --zsh)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bin overrides needs to be here to ensure it's loaded last
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
