# LSPs like expert-lsp seems to fail to load if fzf is installed
# and since it's not possible to conditionally load a zmodule in zimrc
# this prevents loading the whole zimfw when the shell is not interactive
[[ ! -t 0 || ! -o zle ]] && return

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh
