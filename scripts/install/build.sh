#!/usr/bin/env bash

set -euo pipefail

# === define packages ===
build_yay() {
    if ! command -v yay &>/dev/null; then
        echo "=== yay aur installation ==="
        sudo pacman -Sy --needed git base-devel --noconfirm
        git clone "https://aur.archlinux.org/yay-bin.git" "$HOME/yay"
        cd "$HOME/yay" && makepkg -si --noconfirm
        rm -rf "$HOME/yay"
    else
        echo "yay already installed"
    fi
}

build_codelldb() {
    if ! command -v yay &>/dev/null; then
        echo "=== codelldb installation ==="
        curl -fL "https://github.com/vadimcn/codelldb/releases/download/v1.12.2/codelldb-linux-x64.vsix" -o "$HOME/codelldb.zip"
        unzip "$HOME/codelldb.zip" -d "$HOME/codelldb"
        mv "$HOME/codelldb/extension/adapter/codelldb" "$LOCAL_BIN/codelldb"
        rm -rf $HOME/codelldb*
    else
        echo "codelldb already installed"
    fi
}

# === build packages ===
while [[ $# -gt 0 ]]; do
    case $1 in
    --all)
        build_yay
        build_codelldb
        shift
        ;;
    --yay)
        build_yay
        shift
        ;;
    --codelldb)
        build_codelldb
        shift
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done
