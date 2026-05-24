fzf_nvim() {
    if [[ $# -gt 0 ]]; then
        nvim "$@"
        return
    fi

    local selected=$(find . -type f -not -path "**/.git/*" | fzf --preview="bat --color=always {} || cat {}" --preview-window "right:65%")
    if [[ -z "$selected" ]]; then
        return
    fi

    nvim "$selected"
}

alias o='cd $(git rev-parse --show-toplevel)'
alias la="ls --color -lAvh --group-directories-first"
alias xsc="xclip -selection clipboard"
alias glog="git --no-pager log --oneline --decorate --graph --parents"
alias v=fzf_nvim

bindkey "^?" backward-delete-char
bindkey "^Xe" edit-command-line
bindkey "^g" fzf-history-widget
bindkey -s "^r" "source $DOTFILES/zsh/conf.zsh\n"
bindkey -s "^f" "$DOTFILES/scripts/workflow/tmux-sessionizer.sh\n"
