export ZSH="$HOME/zsh"

HISTDUP=erase
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=$HOME/.zsh_history
setopt append_history
setopt inc_append_history
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt globdots
setopt no_bang_hist

eval "$(starship init zsh)"
eval "$(dircolors)"
eval "$(fzf --zsh)"

source $HOME/.dotfiles/zsh/keybinds.zsh

plugins=(fzf-tab zsh-autosuggestions)
for plugin in ${plugins[@]}; do
    source "$ZSH/plugins/$plugin/$plugin.plugin.zsh"
done
