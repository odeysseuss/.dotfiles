export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

export PERSONAL="$HOME/loom"
export DOTFILES="$HOME/.dotfiles"
export LOCAL_BIN="$HOME/.local/bin"
export LOCAL_LIB="/usr/local/lib"
export LOCAL_INC="/usr/local/include"

export PATH="$LOCAL_BIN:$PATH"
export PKG_CONFIG_PATH="$LOCAL_LIB/pkgconfig:$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="$LOCAL_LIB:$LD_LIBRARY_PATH"
export TYPST_FONT_PATHS="$XDG_DATA_HOME/fonts/"

export DISPLAY=:0
export EDITOR="nvim"
export BAT_THEME="gruvbox-dark"
export MANPAGER="nvim +Man!"
export PAGER="bat"

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" >/dev/null
fi
