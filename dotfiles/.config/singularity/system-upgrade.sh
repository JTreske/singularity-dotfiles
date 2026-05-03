#!/usr/bin/env bash

helper=""

_checkCommandExists() {
  cmd="$1"
  if ! command -v "$cmd" >/dev/null; then
    echo 1
    return
  fi
  echo 0
  return
}

_checkAURHelper() {
  if [[ $(_checkCommandExists "paru") == 0 ]]; then
    echo ":: using paru"
    helper="paru"
    return
  fi
  if [[ $(_checkCommandExists "yay") == 0 ]]; then
    echo ":: using yay"
    helper="yay"
    return
  fi

  echo ":: using pacman"
  helper="pacman"
}

_checkAURHelper

echo ":: performing upgrade"
if [[ $helper == "pacman" ]]; then
  sudo pacman -Syu
else
  $helper -Syu
fi

bash <(curl -s https://raw.githubusercontent.com/JTreske/singularity-dotfiles/refs/heads/main/install.sh) --install
