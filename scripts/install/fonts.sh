#!/usr/bin/env bash

set -euo pipefail

# === define packages ===
install_maple() {
    local font_dir="$FONT_PATH/maple_mono"
    local font_zip="$FONT_PATH/maple_fonts.zip"

    mkdir -p $font_dir

    if [[ ! -f "$font_dir/config.json" && ! -f "$font_dir/LICENSE.txt" ]]; then
        echo "=== Maple Fonts Installation ==="
        curl -fL "https://github.com/odeysseuss/.dotfiles/releases/download/Fonts/MapleMono-NF.zip" -o $font_zip
        unzip $font_zip -d $font_dir
        rm -rf $font_zip
    else
        echo "Maple fonts already exists"
    fi
}

install_jetbrains() {
    local font_dir="$FONT_PATH/jetbrains_mono"
    mkdir -p $font_dir

    local fonts=(
        "JetBrainsMono/Ligatures/Light/JetBrainsMonoNerdFontMono-Light.ttf"
        "JetBrainsMono/Ligatures/LightItalic/JetBrainsMonoNerdFontMono-LightItalic.ttf"
        "JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontMono-Regular.ttf"
        "JetBrainsMono/Ligatures/Italic/JetBrainsMonoNerdFontMono-Italic.ttf"
        "JetBrainsMono/Ligatures/SemiBold/JetBrainsMonoNerdFont-SemiBold.ttf"
        "JetBrainsMono/Ligatures/SemiBoldItalic/JetBrainsMonoNerdFont-SemiBoldItalic.ttf"
        "JetBrainsMono/Ligatures/Bold/JetBrainsMonoNerdFontMono-Bold.ttf"
        "JetBrainsMono/Ligatures/BoldItalic/JetBrainsMonoNerdFontMono-BoldItalic.ttf"
    )

    echo "=== JetBrainsMono Nerd Fonts Installation ==="
    for font in "${fonts[@]}"; do
        local font_ttf=$(basename "$font")
        local local_font="$font_dir/$font_ttf"

        if [[ -f "$local_font" ]]; then
            echo -ne "$font_ttf already exists\r"
        else
            echo "Downloading $font_ttf..."
            curl -fL "https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/$font" \
                -o "$local_font" || {
                echo "Failed to install $font_ttf"
                exit 1
            }
        fi
    done
}

install_excalifont() {
    local font="$FONT_PATH/excalifont/excalifont.woff"

    mkdir -p "$(dirname $font)"

    if [[ ! -f $font ]]; then
        echo "=== Excalifont Installation ==="
        curl -fL "https://excalidraw.nyc3.cdn.digitaloceanspaces.com/fonts/Excalifont-Regular.woff2" -o $font
    else
        echo "Excalifont already exists"
    fi
}

install_firamath() {
    local font="$FONT_PATH/firamath/firamath.otf"

    mkdir -p "$(dirname $font)"

    if [[ ! -f $font ]]; then
        echo "=== FirMath Font Installation ==="
        curl -fL "https://github.com/firamath/firamath/releases/download/v0.3.4/FiraMath-Regular.otf" -o $font
    else
        echo "FirMath already exists"
    fi
}

# === install packages ===
while [[ $# -gt 0 ]]; do
    case $1 in
    --all)
        install_maple
        install_jetbrains
        install_excalifont
        install_firamath
        shift
        ;;
    --maple)
        install_maple
        shift
        ;;
    --jetbrains)
        install_jetbrains
        shift
        ;;
    --excalifont)
        install_excalifont
        shift
        ;;
    --firamath)
        install_firamath
        shift
        ;;
    *)
        echo "Unknown option: $1"
        exit 1
        ;;
    esac
done
