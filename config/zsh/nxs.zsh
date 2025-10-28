scripts_dir="${0:A:h}"

scripts=(
  env.zsh
  zim.zsh
  prompt.zsh
  alias.zsh
)

for s in $scripts; do
  source "$scripts_dir/$s"
done

unset scripts_dir
unset scripts

# Ensure coreutils path takes precedence
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

