export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export PATH=$PATH:${HOME}/.cargo/bin/
export PATH=$PATH:${HOME}/.local/bin/

export EDITOR="fresh"
export VISUAL="fresh"
export MANPAGER="nvim +Man!"

export HISTFILE="$BDOTDIR/.history"
export HISTSIZE=10000
export SAVEHIST=10000

export STARSHIP_CONFIG=${HOME}/.config/starship/starship.toml
