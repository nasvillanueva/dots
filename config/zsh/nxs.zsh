source ./plugins.zsh
source ./completions.zsh
source ./aliases.zsh

# Options
set -o emacs

# Theme
PROMPT='%B%(?.%F{blue}>.%F{red}>)%f%b '
