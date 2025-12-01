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

ZSH_THEME_GIT_PROMPT_PREFIX="on %{$fg_bold[blue]%} git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

setopt prompt_subst

PROMPT="
%{$fg_bold[cyan]%}%~%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'
PROMPT+="
%{$fg_bold[green]%}❯ %{$reset_color%}"
