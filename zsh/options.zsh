# ==================================================
# Zsh Options & History
# ==================================================

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt appendhistory
setopt sharehistory
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify

setopt autocd
setopt interactivecomments
setopt no_beep
setopt prompt_subst

# Remove duplicated PATH entries
typeset -U path PATH
