source $NXS_ZSH_HOME/nxs.zsh

[ -s "$HOME/.zshrc_work" ] && source "$HOME/.zshrc_work"

# .zshrc gets loaded last, so we need to put homebrew env here
# to ensure that they take precedence.
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CURLRC="$HOME/.curlrc"
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

# fzf is installed by homebrew, so we need this to come after
source <(fzf --zsh)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
