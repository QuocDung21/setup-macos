#!/usr/bin/env bash
# ==============================================================================
# MAC OS AUTOMATED SETUP SCRIPT
# ==============================================================================

echo "🚀 Starting MacBook setup process..."

# 1. Install Apple Command Line Tools (if not installed)
if ! command -v xcode-select &> /dev/null; then
    echo "📦 Installing Xcode Command Line Tools..."
    xcode-select --install
else
    echo "✅ Xcode Command Line Tools are already installed."
fi

# 2. Install Homebrew (if not installed)
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Activate Homebrew for the current session
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew is already installed."
fi

# 3. Install software and tools via Homebrew
echo "📥 Installing essential CLI tools..."
brew update
brew install zinit       # Zsh Plugin Manager
brew install fzf         # Command-line fuzzy finder
brew install zoxide      # Smarter cd command
brew install eza         # Modern replacement for ls with colors and icons
brew install pyenv       # Python version management
brew install nvm         # Node.js version management
brew install pnpm        # Fast, disk space efficient package manager
# (You can add brew install --cask commands here, e.g., google-chrome, visual-studio-code)

# 4. Create Zsh configuration directory structure
echo "📁 Creating ~/.zsh_custom directory structure..."
mkdir -p "$HOME/.zsh_custom"

# 5. Initialize ~/.zsh_custom/paths.zsh
echo "✍️ Writing paths.zsh..."
cat << 'EOF' > "$HOME/.zsh_custom/paths.zsh"
# ==============================================================================
# 1. ROOT VARIABLES
# ==============================================================================
export PYENV_ROOT="$HOME/.pyenv"
export NVM_DIR="$HOME/.nvm"
export JAVA_HOME="$(/usr/libexec/java_home -v 21 2>/dev/null || /usr/libexec/java_home -v 17 2>/dev/null)"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"
export MAMBA_ROOT_PREFIX="$HOME/micromamba"
export PNPM_HOME="$HOME/Library/pnpm"

# ==============================================================================
# 2. PATH EXPORTS
# ==============================================================================
export PATH="$PNPM_HOME/bin:$PATH"
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
EOF

# 6. Initialize ~/.zsh_custom/tools.zsh
echo "✍️ Writing tools.zsh..."
cat << 'EOF' > "$HOME/.zsh_custom/tools.zsh"
# Initialize helper tools
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# Initialize lazy-load (if needed) for pyenv and nvm here
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
EOF

# 7. Initialize ~/.zsh_custom/aliases.zsh
echo "✍️ Writing aliases.zsh..."
cat << 'EOF' > "$HOME/.zsh_custom/aliases.zsh"
# Common aliases
alias ls="eza --icons=always --color=always"
alias ll="eza -l --icons=always --color=always"
alias la="eza -a --icons=always --color=always"
alias c="clear"
alias zshconfig="code ~/.zshrc"
EOF

# 8. Overwrite standard ~/.zshrc file
echo "✍️ Writing ~/.zshrc..."
cat << 'EOF' > "$HOME/.zshrc"
# ==============================================================================
# 1. POWERLEVEL10K INSTANT PROMPT (MUST BE AT THE VERY TOP)
# ==============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# 2. HOMEBREW (Load early to initialize HOMEBREW_PREFIX and env variables)
# ==============================================================================
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ==============================================================================
# 3. LOAD MODULAR CUSTOM CONFIG FILES
# ==============================================================================
source "$HOME/.zsh_custom/paths.zsh"
source "$HOME/.zsh_custom/tools.zsh"
source "$HOME/.zsh_custom/aliases.zsh"

# ==============================================================================
# 4. ZINIT & PLUGINS (REPLACING OH MY ZSH)
# ==============================================================================
source /opt/homebrew/opt/zinit/zinit.zsh

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit snippet OMZL::history.zsh
zinit snippet OMZL::completion.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::extract
zinit snippet OMZP::copydir

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

autoload -Uz compinit
compinit
zinit cdreplay -q

zinit light zsh-users/zsh-syntax-highlighting

# ==============================================================================
# 5. CLEAN UP PATH & RESET HASH
# ==============================================================================
typeset -U path PATH
hash -r

# ==============================================================================
# 6. LOAD P10K CONFIG (MUST BE AT THE VERY BOTTOM)
# ==============================================================================
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
EOF

echo "🎉 Setup process completed!"
echo "👉 Please run 'exec zsh' or restart your Terminal."
echo "👉 After restarting, Zinit will automatically download plugins and Powerlevel10k will show the configuration wizard (if ~/.p10k.zsh doesn't exist)."
