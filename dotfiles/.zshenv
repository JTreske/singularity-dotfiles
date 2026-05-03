export ZDOTDIR="${HOME}/.config/zsh"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"

export PATH=$PATH:${HOME}/.cargo/bin/
export PATH=$PATH:${HOME}/.local/bin/

export EDITOR="fresh"
export VISUAL="fresh"
export MANPAGER="nvim +Man!"

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

export ANTIDOTE_HOME=${HOME}/.cache/antidote
export STARSHIP_CONFIG=${HOME}/.config/starship/starship.toml
