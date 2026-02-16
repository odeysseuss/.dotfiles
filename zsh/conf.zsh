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

bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
autoload -U compinit
compinit
zstyle ':completion:*' menu select

eval "$(starship init zsh)"
eval "$(dircolors)"

source <(fzf --zsh)
source $HOME/.dotfiles/zsh/keybinds.zsh

plugins=(fzf-tab zsh-autosuggestions zsh-z)
for plugin in ${plugins[@]}; do
    source "$ZSH/plugins/$plugin/$plugin.plugin.zsh"
done

test -f "/home/robb/.xmake/profile" && source "/home/robb/.xmake/profile"
