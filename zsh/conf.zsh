export ZSH="$HOME/zsh"

eval $(dircolors)
autoload -U colors && colors
autoload -U compinit
compinit
_comp_options+=(globdots)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

plugins=(fzf-tab zsh-autosuggestions)

for plugin in ${plugins[@]}; do
    source "$ZSH/plugins/$plugin/$plugin.plugin.zsh"
done

function git_prompt_info() {
    local ref
    ref=$(command git symbolic-ref HEAD 2>/dev/null) ||
        ref=$(command git rev-parse --short HEAD 2>/dev/null) || return 0

    local dirty
    if [[ -n $(command git status --porcelain 2>/dev/null) ]]; then
        dirty="$ZSH_THEME_GIT_PROMPT_DIRTY"
    else
        dirty="$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi

    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$dirty$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

setopt prompt_subst

PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'

source $HOME/.dotfiles/zsh/keybinds.zsh
source $HOME/.cargo/env
source <(fzf --zsh)

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
