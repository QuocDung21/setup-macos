#
export PYENV_ROOT="$HOME/.pyenv"
export NVM_DIR="$HOME/.nvm"
export JAVA_HOME="$(/usr/libexec/java_home -v 21 2>/dev/null || /usr/libexec/java_home -v 17 2>/dev/null)"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"
export MAMBA_ROOT_PREFIX="$HOME/micromamba"
export PNPM_HOME="$HOME/Library/pnpm"

# PATH
export PATH="$PYENV_ROOT/bin:$PATH"
[[ -n "$JAVA_HOME" ]] && export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"
export PATH="$HOME/fvm/versions/stable/bin:$HOME/.pub-cache/bin:$PATH"
export PATH="/opt/homebrew/opt/dotnet/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$HOME/.pixi/bin:$PATH"
export PATH="$MAMBA_ROOT_PREFIX/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"

# PNPM PATH
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
