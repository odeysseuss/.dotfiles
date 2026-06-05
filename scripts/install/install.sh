#!/usr/bin/env bash

set -euo pipefail

zsh=$HOME/zsh/plugins
tmux=$HOME/tmux/plugins

mkdir -p $zsh
mkdir -p $tmux

git clone "https://github.com/zsh-users/zsh-autosuggestions.git" "$zsh/zsh-autosuggestions"
git clone "https://github.com/Aloxaf/fzf-tab.git" "$zsh/fzf-tab"

git clone "https://github.com/tmux-plugins/tmux-resurrect" "$tmux/tmux-resurrect"
git clone "https://github.com/tmux-plugins/tmux-continuum" "$tmux/tmux-continuum"
