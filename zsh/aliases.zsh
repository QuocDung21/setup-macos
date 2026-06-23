# ==================================================
# Aliases
# ==================================================

alias reload="source ~/.zshrc"
alias zshalias="nano ~/.config/zsh/aliases.zsh"

# Modern CLI
command -v eza >/dev/null 2>&1 && alias ls="eza"
command -v eza >/dev/null 2>&1 && alias ll="eza -lah --group-directories-first --icons=auto"
command -v eza >/dev/null 2>&1 && alias la="eza -a --icons=auto"

alias ..="cd .."

# Git
alias gs="git status"
alias ga="git add"
alias gcm="git commit -m"
alias gp="git push"
