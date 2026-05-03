export BDOTDIR="$HOME/.config/bash"

source $BDOTDIR/env.bash
source $BDOTDIR/alias.bash

eval "$(zoxide init bash)"
eval "$(fzf --bash)"

eval "$(starship init bash)"

fastfetch
