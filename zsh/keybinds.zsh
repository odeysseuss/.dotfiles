fzf_nvim() {
    if [[ $# -gt 0 ]]; then
        nvim "$@"
        return
    fi

    local selected=$(rg --files --hidden --glob "!**/.git/*" | fzf --multi --preview="bat --color=always {} || cat {}" --preview-window "right:65%")
    if [[ -z "$selected" ]]; then
        return
    fi

    local files=()
    while IFS= read -r line; do
        files+=("$line")
    done <<<"$selected"

    nvim "${files[@]}"
}

bstrace() {
    stdbuf -o0 strace "$@" 2>&1 | bat --no-pager -l c
}

bltrace() {
    stdbuf -o0 ltrace "$@" 2>&1 | bat --no-pager -l c
}

alias o='cd $(git rev-parse --show-toplevel)'
alias la="ls --color -lAvh --group-directories-first"
alias z="$DOTFILES/scripts/fzfm/fzfm.sh"
alias xsc="xclip -selection clipboard"
alias glog="git --no-pager log --oneline --decorate --graph --parents"
alias vi=fzf_nvim
alias python="python3"

bindkey -v
autoload -U edit-command-line
zle -N edit-command-line
autoload -U compinit
compinit

bindkey "^?" backward-delete-char
bindkey "^Xe" edit-command-line
bindkey "^g" fzf-history-widget
bindkey -s "^r" "source $DOTFILES/zsh/conf.zsh\n"
bindkey -s "^f" "$DOTFILES/scripts/workflow/tmux-sessionizer.sh\n"
bindkey -s "^y" "yazi\n"
