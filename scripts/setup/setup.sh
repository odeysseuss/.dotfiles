#!/usr/bin/env bash

set -euo pipefail

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
NC='\033[0m'

status() {
    echo -e "${BLUE}=== $1${NC}"
}

error() {
    echo -e "${RED}✗ $1${NC}" >&2
}

export XDG_CONFIG_HOME=$HOME/.config
export DOTFILES="$HOME/.dotfiles"
export LOCAL_BIN="$HOME/.local/bin"
export PERSONAL="$HOME/loom"
export ZSH="$HOME/zsh"

user="$1"
keyname="$2"
passphrase="$3"

status "Yay installation..."
curl -fsSL "https://raw.githubusercontent.com/odeysseuss/.dotfiles/refs/heads/master/scripts/setup/build.sh" | sh -s -- --yay || {
    error "Yay installation failed"
    exit 1
}
status "Installing packages..."
curl -fsSL "https://raw.githubusercontent.com/odeysseuss/.dotfiles/refs/heads/master/scripts/setup/install.sh" | sh || {
    error "Failed to run dotfiles install script"
    exit 1
}

status "Cloning dotfiles repository..."
if [[ ! -d "$DOTFILES" ]]; then
    git clone https://github.com/odeysseuss/.dotfiles.git $DOTFILES || {
        error "Failed to clone dotfiles repository"
        exit 1
    }
fi
status "Installing fonts..."
"$DOTFILES/fonts/maple_fonts.sh" || {
    error "Failed to install fonts"
    exit 1
}
status "Installing dotfiles..."
"$DOTFILES/scripts/setup/symlinks.sh" --overwrite-all || {
    error "Failed to create symlinks"
    exit 1
}

status "Changing default shell..."
zsh_path=$(which zsh)
if ! grep -q "$zsh_path" /etc/shells 2>/dev/null; then
    echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
fi
if [ "$SHELL" != "$zsh_path" ]; then
    sudo chsh -s "$zsh_path" "$user" || {
        error "Failed to change default shell to zsh"
        exit 1
    }
fi

mkdir -p $ZSH/plugins $ZSH/themes
status "Installing zsh plugins..."
if [[ ! -d "$ZSH/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH/plugins/zsh-autosuggestions || {
        error "Failed to clone zsh-autosuggestions"
        exit 1
    }
fi
if [[ ! -d "$ZSH/plugins/fzf-tab" ]]; then
    git clone https://github.com/Aloxaf/fzf-tab.git $ZSH/plugins/fzf-tab || {
        error "Failed to clone fzf-tab"
        exit 1
    }
fi

status "Generating new SSH key..."
SSH_DIR=$HOME/.ssh
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"
if [[ ! -f "$SSH_DIR/$keyname" ]]; then
    $DOTFILES/scripts/setup/sshkey.sh -a "github*" -m "git" -H "github.com" -f "$keyname" -N "$passphrase" || {
        error "Failed to generate SSH key"
        exit 1
    }
fi
