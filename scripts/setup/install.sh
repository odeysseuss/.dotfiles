#!/usr/bin/env bash

set -euo pipefail

pkg_manager="yay -S --needed --noconfirm"
config_file="${DOTFILES:-$HOME/.dotfiles}/packages.toml"

total_packages=0
to_install=0
already_installed=0

get_categories() {
    yq eval "keys | .[]" "$config_file" 2>/dev/null || true
}

get_packages() {
    yq eval ".${1}.packages // [] | .[]" "$config_file" 2>/dev/null || true
}

get_package_count() {
    yq eval ".${1}.packages // [] | length" "$config_file" 2>/dev/null || echo "0"
}

if ! command -v yq &>/dev/null; then
    $pkg_manager go-yq
fi

installed_packages=$(yay -Qq 2>/dev/null || true)

categories=$(get_categories)

for category in $categories; do
    echo -e "${CYAN}[$category]${NC}"

    packages=$(get_packages "$category")
    count=$(get_package_count "$category")

    if [[ $count -eq 0 ]]; then
        echo -e "  ${YELLOW}No packages in this category${NC}"
        echo ""
        continue
    fi

    total_packages=$((total_packages + count))
    category_to_install=()

    for pkg in $packages; do
        if echo "$installed_packages" | grep -q "^$pkg$"; then
            echo -e "  ${GREEN}✓${NC} $pkg"
            already_installed=$((already_installed + 1))
        else
            echo -e "  ${BLUE}+${NC} $pkg"
            category_to_install+=("$pkg")
        fi
    done

    echo ""
    echo -e "  ${BLUE}|> Installing ${#category_to_install[@]} packages...${NC}"
    if $pkg_manager "${category_to_install[@]}"; then
        to_install=$((to_install + ${#category_to_install[@]}))
        echo -e "  ${GREEN}|> Done${NC}"
    else
        echo -e "  ${RED}|> Failed${NC}"
    fi

    echo ""
done

echo -e "${CYAN}[Summary]${NC}"
echo -e "  ${BLUE}|> Total packages: $total_packages${NC}"
echo -e "  ${YELLOW}|> Already installed: $already_installed${NC}"
echo -e "  ${GREEN}|> Newly installed: $to_install${NC}"
