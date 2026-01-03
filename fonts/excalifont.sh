#!/usr/bin/env bash

set -euo pipefail

FONT_PATH=$XDG_DATA_HOME/fonts
excalifont=$FONT_PATH/excalifont/excalifont.woff

mkdir -p "$(dirname $excalifont)"

if [[ ! -f $excalifont ]]; then
    curl -fL "https://excalidraw.nyc3.cdn.digitaloceanspaces.com/fonts/Excalifont-Regular.woff2" -o $excalifont
else
    echo "Excalifont already exists"
fi
