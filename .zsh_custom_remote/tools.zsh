# Pyenv
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# NVM
if [[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]]; then
  . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
fi

# Zoxide
eval "$(zoxide init zsh)"
