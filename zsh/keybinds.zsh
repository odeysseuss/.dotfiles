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


fzf_completion() {
    local commands=(
        "perf stat -e cycles,instructions,bus-cycles,cpu-clock,task-clock"
        "perf stat -e branches,branch-misses,caches,cache-misses"
        "perf stat -e L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores"
        "perf stat -e dTLB-loads,dTLB-load-misses,dTLB-prefetch-misses"
        "perf stat -e LLC-loads,LLC-load-misses,LLC-stores,LLC-prefetches"
        "perf record -F 99 --call-graph dwarf"
        "perf script report flamegraph"
        "xdg-open"
        "perf report"
    )

    local selected=$(printf "%s\n" "${commands[@]}" | fzf)

    LBUFFER="${LBUFFER}${selected}"
    zle redisplay
}

zle -N fzf_completion

alias o='cd $(git rev-parse --show-toplevel)'
alias la="ls --color -lAvh --group-directories-first"
alias xsc="xclip -selection clipboard"
alias glog="git --no-pager log --oneline --decorate --graph"
alias v=fzf_nvim

bindkey "^?" backward-delete-char
bindkey "^Xe" edit-command-line
bindkey "^g" fzf-history-widget
bindkey "^p" fzf_completion
bindkey -s "^r" "source $DOTFILES/zsh/conf.zsh\n"
bindkey -s "^f" "$DOTFILES/scripts/workflow/tmux-sessionizer.sh\n"
