#!/usr/bin/env bash

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

### UI ###
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() {
  echo -e "${RED}[ERROR]${NC} $1"
  exit 1
}

install_dotfiles() {
  echo "Installing singularity-dotfiles-manager..."
  cargo install --git "https://github.com/JTreske/singularity-dotfiles-manager.git"

  if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    warn "~/.local/bin is not in your PATH. Adding it for this session..."
    export PATH="$HOME/.local/bin:$PATH"

    if [[ -f "$HOME/.bashrc" ]] && ! grep -q ".local/bin" "$HOME/.bashrc"; then
      info "Adding ~/.local/bin to your .bashrc for future sessions..."
      echo 'export PATH="$HOME/.local/bin:$PATH"' >>"$HOME/.bashrc"
    fi
  fi
  if [[ ":$PATH:" != *":$HOME/.cargo/bin:"* ]]; then
    warn "~/.cargo/bin is not in your PATH. Adding it for this session..."
    export PATH="$HOME/.cargo/bin:$PATH"

    if [[ -f "$HOME/.bashrc" ]] && ! grep -q ".cargo/bin" "$HOME/.bashrc"; then
      info "Adding ~/.cargo/bin to your .bashrc for future sessions..."
      echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>"$HOME/.bashrc"
    fi
  fi

  singularity_release=$(gum choose --header "Choose the singularity dotfiles version:" "stable" "rolling")

  info "Launching singularity-dotfiles-manager..."
  singularity-dotfiles-manager install https://raw.githubusercontent.com/JTreske/singularity-dotfiles/refs/heads/main/singularity-dotfiles-${singularity_release}.json
}

set_shell() {
  local choice=$(gum choose --header "Choose your shell:" "zsh" "bash")
  chsh -s /usr/bin/${choice}

  success "Shell ${choice} set as default!"
}

multilib() {
  info "Enabling multilib repository..."
  sudo cp /etc/pacman.conf /etc/pacman.conf.bak
  # Uncomment the [multilib] repository and its Include line
  local mline=$(grep -n "\\[multilib\\]" /etc/pacman.conf | cut -d: -f1)
  local rline=$(($mline + 1))

  sudo sed -i ''$mline's|#\[multilib\]|\[multilib\]|g' /etc/pacman.conf
  sudo sed -i ''$rline's|#Include = /etc/pacman.d/mirrorlist|Include = /etc/pacman.d/mirrorlist|g' /etc/pacman.conf

  success "Multilib repository enabled!"
}

install_apps() {
  singularity-dotfiles-manager apps
}

sddm_silent_theme() {
  info "Installing singularity custom SDDM theme to expected silent theme location..."
  sudo cp "${HOME}/.config/singularity/singularity.jpg" "/usr/share/sddm/themes/silent/backgrounds/singularity.jpg"
  sudo cp "${HOME}/.config/sddm-silent/singularity.conf" "/usr/share/sddm/themes/silent/configs/singularity.conf"

  info "Updating SDDM theme..."

  cat <<EOF | sudo tee /etc/sddm.conf >/dev/null
[General]
InputMethod=qtvirtualkeyboard
GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard

[Theme]
Current=silent
EOF

  local target_file="/usr/share/sddm/themes/silent/metadata.desktop"
  local new_path="configs/singularity.conf"

  if [[ ! -f "$target_file" ]]; then
    error "Theme metadata file not found at '$target_file'"
    return 1
  fi

  sudo sed -i "s|^ConfigFile=.*|ConfigFile=$new_path|" "$target_file"
  success "SDDM theme updated!"
}

sddm_wallpaper() {
  info "Updating SDDM wallpaper..."
  local image=$(gum file --header "Select your wallpaper:" -a $HOME/.config/wallpaper)

  if [[ "$image" == "no file selected" || -z "$image" ]]; then
    warn "Set wallpaper operation cancelled: No file selected."
    return
  fi

  local target_file="$HOME/.config/sddm-silent/singularity.conf"
  sudo sed -i "s|^background = .*|background = \"$image\"|" "$target_file"

  success "SDDM wallpaper updated!"
}

avatar() {
  local image=$(gum file --header "Select your avatar:" -a $HOME)

  if [[ "$image" == "no file selected" || -z "$image" ]]; then
    warn "Set avatar operation cancelled: No file selected."
    return
  fi

  local face="${HOME}/.face"
  info "Setting '$face' ..."
  cp "$image" "$face"

  info "Setting SDDM avatar ..."
  /usr/share/sddm/themes/silent/change_avatar.sh "$USER" "$face"

  success "Avatar install finished!"
}

if ! command -v cargo &>/dev/null; then
  echo "Rust not found. Installing via rustup..."
  sudo pacman --noconfirm --needed -S "rustup"
  rustup default stable
else
  echo "Rust is already installed."
fi

if ! command -v gum &>/dev/null; then
  echo "Installing gum..."
  sudo pacman --noconfirm --needed -S "gum"
else
  echo "Gum is already installed."
fi

### CLI ###
usage() {
  local script_name=$(basename "$0")
  echo "Usage: $script_name [OPTIONS]"
  echo "Default: $script_name -i --ask"
  echo "Options:"
  echo "  --ask           Ask before each step (except steps explicitely mentioned)"
  echo "  -i --install    Run install step or update if already present"
  echo "  -s --shell      Set the shell for your user"
  echo "  -m --multilib   Add multilib repository"
  echo "  -a --apps       Choose from a curated list of apps"
  echo "  -t --theme      Set SDDM theme"
  echo "  -w --wallpaper  Set SDDM wallpaper"
  echo "  -f --avatar     Set the avatar for your user profile"
  exit 1
}

# Usage: run_step "<flag:true/false>" "<short description>" "<default:true/false> "task_function"
run_step() {
  local flag=$1
  local description=$2
  local default=$3
  local task_function=$4

  if [[ "$flag" == true ]]; then
    $task_function
  elif [[ "$ASK" == true ]]; then
    if gum confirm --default="${default}" "Do you want to $description?"; then
      $task_function
    else
      info "Skipping $description."
    fi
  fi
}

ASK=false
INSTALL=false
SHELL=false
MULTILIB=false
APPS=false
THEME=false
WALLPAPER=false
AVATAR=false

# Default case
if [[ $# -eq 0 ]]; then
  INSTALL=true
  ASK=true
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
  --ask)
    ASK=true
    shift
    ;;
  -i | --install)
    INSTALL=true
    shift
    ;;
  -s | --shell)
    SHELL=true
    shift
    ;;
  -m | --multilib)
    MULTILIB=true
    shift
    ;;
  -a | --apps)
    APPS=true
    shift
    ;;
  -t | --theme)
    THEME=true
    shift
    ;;
  -w | --wallpaper)
    WALLPAPER=true
    shift
    ;;
  -f | --avatar)
    AVATAR=true
    shift
    ;;
  -h | --help)
    usage
    ;;
  *)
    echo "Unknown option: $1"
    usage
    ;;
  esac
done

run_step "$INSTALL" "install singularity dotfiles" "true" install_dotfiles
run_step "$SHELL" "set your shell (recommended for first install)" "true" set_shell
run_step "$MULTILIB" "add multilib repository needed for 32-bit apps, e.g., Steam" "true" multilib
run_step "$APPS" "install apps from curated list" "false" install_apps
run_step "$THEME" "set SDDM (login screen) silent custom theme" "true" sddm_silent_theme
run_step "$WALLPAPER" "set SDDM (login screen) wallpaper" "false" sddm_wallpaper
run_step "$AVATAR" "set an avatar picture" "false" avatar
