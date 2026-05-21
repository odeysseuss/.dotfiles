export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export PERSONAL="$HOME/loom"
export DOTFILES="$HOME/.dotfiles"
export LOCAL_BIN="$HOME/.local/bin"
export LOCAL_LIB="$HOME/.local/lib"
export LOCAL_INC="$HOME/.local/include"
export FONT_PATH="$XDG_DATA_HOME/fonts"

export PATH="$LOCAL_BIN:$PATH"
export PKG_CONFIG_PATH="$LOCAL_LIB/pkgconfig:$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH="$LOCAL_LIB:$LD_LIBRARY_PATH"
export TYPST_FONT_PATHS="$FONT_PATH"

export EDITOR="nvim"
export BAT_THEME="gruvbox-dark"
export MANPAGER="nvim +Man!"
export PAGER="bat"

if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" >/dev/null
fi
