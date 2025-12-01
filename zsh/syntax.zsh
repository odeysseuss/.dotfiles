# Cyberdream Theme (for zsh-syntax-highlighting)
#
# Paste this files contents inside your ~/.zshrc before you activate zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES

# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
#
## General
### Diffs
### Markup
## Classes
## Comments
ZSH_HIGHLIGHT_STYLES[comment]='fg=#3c4048'
## Constants
## Entitites
## Functions/methods
ZSH_HIGHLIGHT_STYLES[alias]='fg=#5ea1ff'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#5ea1ff'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#5ea1ff'
ZSH_HIGHLIGHT_STYLES[function]='fg=#5ea1ff'
ZSH_HIGHLIGHT_STYLES[command]='fg=#5ea1ff'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#5ea1ff,italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#ffbd5e,italic'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#ffbd5e'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ffbd5e'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#bd5eff'
## Keywords
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#f1ff5e'
## Built ins
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#5ea1ff'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#ff5ea0'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#5ea1ff'
## Punctuation
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#f1ff5e'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#f1ff5e'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#ff6e5e'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#ff6e5e'
## Serializable / Configuration Languages
## Storage
## Strings
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#5eff6c'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#5eff6c'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#ff6e5e'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#5eff6c'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#ff6e5e'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#5eff6c'
## Variables
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#5ef1ff'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#ff6e5e'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#5ef1ff'
ZSH_HIGHLIGHT_STYLES[dollar-unquoted-argument]='fg=#5ef1ff'
ZSH_HIGHLIGHT_STYLES[dollar-unquoted-argument-unclosed]='fg=#ff6e5e'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#5ef1ff'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#5ef1ff'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#5ef1ff'
## No category relevant in spec
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ff6e5e'
ZSH_HIGHLIGHT_STYLES[path]='fg=#ffffff,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#ffffff,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#ffffff'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#bd5eff'
# Additional styles for brackets and braces
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#ff6e5e'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[brace-expansion]='fg=#ff5ef1'
# Arithmetic expansion
ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=#ff5ef1'
# Command and process substitution
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=#ff5ef1'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#ff6e5e'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#ffffff'
ZSH_HIGHLIGHT_STYLES[default]='fg=#ffffff'
ZSH_HIGHLIGHT_STYLES[cursor]='fg=#ffffff'
