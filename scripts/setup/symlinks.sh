#!/usr/bin/env bash

set -euo pipefail

dotfiles=$HOME/.dotfiles
overwrite_all=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
    --overwrite-all) overwrite_all=true ;;
    *)
        echo "Unknown parameter: $1"
        exit 1
        ;;
    esac
    shift
done

link_file() {
    local src=$1 dst=$2
    local overwrite=false backup=false skip=false

    if [[ -e "$dst" ]]; then
        local currentSrc=$(readlink "$dst" 2>/dev/null || true)

        if [ "$currentSrc" = "$src" ]; then
            echo "Skip: $dst (already linked)"
            return
        fi

        if [ "$overwrite_all" = "true" ]; then
            rm -rf "$dst"
            echo "Remove: $dst (overwrite all)"
        else
            echo "File exists: $dst"
            echo "  [s]kip, [o]verwrite, [b]ackup?"
            read -n 1 action </dev/tty
            echo

            case "$action" in
            o)
                rm -rf "$dst"
                echo "Remove: $dst"
                ;;
            b)
                mv "$dst" "${dst}.bak"
                echo "Backup: $dst -> ${dst}.bak"
                ;;
            s | *)
                echo "Skip: $dst"
                return
                ;;
            esac
        fi
    fi

    ln -s "$src" "$dst"
    echo "Link: $src -> $dst"
}

install_dotfiles() {
    find "$dotfiles" -maxdepth 2 -name 'links.sh' -not -path '*.git*' | while read linkfile; do
        while IFS='=' read -r src dst; do
            [[ -z "$src" ]] && continue
            src=$(eval echo "$src")
            dst=$(eval echo "$dst")
            dir=$(dirname "$dst")

            mkdir -p "$dir"
            link_file "$src" "$dst"
        done <"$linkfile"
    done
}

install_dotfiles
