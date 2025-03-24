autoload -U colors && colors
setopt prompt_subst

PROMPT='%B%(?.%F{blue}>.%F{red}>)%f%b '
