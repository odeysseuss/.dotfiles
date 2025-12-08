#!/usr/bin/env bash

set -e

pkg_manager="yay -S --needed --noconfirm"
config_file="${DOTFILES:-$HOME/.dotfiles}/packages.toml"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

total_packages=0
to_install=0
already_installed=0

get_categories() {
    yq eval 'keys | .[]' "$config_file" 2>/dev/null || true
}

get_packages() {
    yq eval ".${1}.packages // [] | .[]" "$config_file" 2>/dev/null || true
}

get_package_count() {
    yq eval ".${1}.packages // [] | length" "$config_file" 2>/dev/null || echo "0"
}

if ! command -v yq &>/dev/null; then
    echo -e "${RED}Error: yq is required.${NC}"
    $pkg_manager yq-go
    exit 1
fi

installed_packages=$(yay -Qq 2>/dev/null || true)

categories=$(get_categories)

for category in $categories; do
    echo -e "${YELLOW}[$category]${NC}"

    packages=$(get_packages "$category")
    count=$(get_package_count "$category")

    if [[ $count -eq 0 ]]; then
        echo "  No packages in this category"
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
    echo "  Installing ${#category_to_install[@]} packages..."
    if $pkg_manager "${category_to_install[@]}"; then
        to_install=$((to_install + ${#category_to_install[@]}))
        echo -e "  ${GREEN}Done${NC}"
    else
        echo -e "  ${RED}Failed${NC}"
    fi

    echo ""
done

echo -e "${BLUE}=== Summary ===${NC}"
echo -e "Total packages: $total_packages"
echo -e "Already installed: ${GREEN}$already_installed${NC}"
echo -e "Newly installed: ${BLUE}$to_install${NC}"
