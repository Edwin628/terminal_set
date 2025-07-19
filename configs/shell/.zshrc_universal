# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# Cross-platform Zsh Configuration
# =============================================================================

# Detect operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    export OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export OS="linux"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    export OS="windows"
else
    export OS="unknown"
fi

# Detect architecture
export ARCH=$(uname -m)

# =============================================================================
# Oh My Zsh Configuration
# =============================================================================

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# =============================================================================
# Cross-platform PATH Configuration
# =============================================================================

# Function to safely add path if it exists
add_to_path() {
    local path_to_add="$1"
    if [[ -d "$path_to_add" && ":$PATH:" != *":$path_to_add:"* ]]; then
        export PATH="$path_to_add:$PATH"
    fi
}

# Function to safely add path if it exists (append)
add_to_path_end() {
    local path_to_add="$1"
    if [[ -d "$path_to_add" && ":$PATH:" != *":$path_to_add:"* ]]; then
        export PATH="$PATH:$path_to_add"
    fi
}

# =============================================================================
# Platform-specific configurations
# =============================================================================

case "$OS" in
    "macos")
        # macOS specific configurations
        echo "Loading macOS configuration..." >&2
        
        # Homebrew paths (Intel and Apple Silicon)
        add_to_path "/opt/homebrew/bin"
        add_to_path "/usr/local/Homebrew/bin"
        add_to_path "/usr/local/bin"
        
        # Homebrew shell environment
        if command -v /opt/homebrew/bin/brew >/dev/null 2>&1; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif command -v /usr/local/Homebrew/bin/brew >/dev/null 2>&1; then
            eval "$(/usr/local/Homebrew/bin/brew shellenv)"
        fi
        
        # Python path
        if command -v brew >/dev/null 2>&1; then
            add_to_path_end "$(brew --prefix)/opt/python/libexec/bin"
        fi
        
        # MySQL path
        add_to_path "/usr/local/mysql/bin"
        
        # Zsh plugins (Homebrew)
        ZSH_AUTOSUGGESTIONS_PATH="/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        ZSH_SYNTAX_HIGHLIGHTING_PATH="/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        ZSH_COMPLETIONS_PATH="/opt/homebrew/share/zsh-completions"
        ;;
        
    "linux")
        # Linux specific configurations
        echo "Loading Linux configuration..." >&2
        
        # Common Linux paths
        add_to_path "/usr/local/bin"
        add_to_path "/usr/bin"
        add_to_path "$HOME/.local/bin"
        
        # Snap packages
        add_to_path "/snap/bin"
        
        # Flatpak
        add_to_path "/var/lib/flatpak/exports/bin"
        add_to_path "$HOME/.local/share/flatpak/exports/bin"
        
        # Zsh plugins (package manager)
        ZSH_AUTOSUGGESTIONS_PATH="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        ZSH_SYNTAX_HIGHLIGHTING_PATH="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        ZSH_COMPLETIONS_PATH="/usr/share/zsh-completions"
        
        # Alternative paths for different distributions
        if [[ ! -f "$ZSH_AUTOSUGGESTIONS_PATH" ]]; then
            ZSH_AUTOSUGGESTIONS_PATH="/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
        fi
        if [[ ! -f "$ZSH_SYNTAX_HIGHLIGHTING_PATH" ]]; then
            ZSH_SYNTAX_HIGHLIGHTING_PATH="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        fi
        ;;
        
    "windows")
        # Windows specific configurations
        echo "Loading Windows configuration..." >&2
        
        # Windows paths
        add_to_path "/c/Program Files/Git/bin"
        add_to_path "/c/Program Files/Git/usr/bin"
        add_to_path "/c/Program Files/Git/mingw64/bin"
        
        # Zsh plugins (Git Bash)
        ZSH_AUTOSUGGESTIONS_PATH="/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
        ZSH_SYNTAX_HIGHLIGHTING_PATH="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
        ZSH_COMPLETIONS_PATH="/usr/share/zsh-completions"
        ;;
        
    *)
        echo "Unknown operating system: $OS" >&2
        ;;
esac

# =============================================================================
# Development Tools Configuration
# =============================================================================

# Go configuration
if command -v go >/dev/null 2>&1; then
    export GOPATH="$HOME/go"
    export GOROOT="$(go env GOROOT 2>/dev/null || echo '/usr/local/go')"
    add_to_path_end "$GOPATH/bin"
    add_to_path "$GOROOT/bin"
else
    echo "Go not found, skipping Go configuration" >&2
fi

# Node.js and NVM
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
fi
if [[ -s "$NVM_DIR/bash_completion" ]]; then
    source "$NVM_DIR/bash_completion"
fi

# Python and Conda
if [[ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]]; then
    source "$HOME/anaconda3/etc/profile.d/conda.sh"
elif [[ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]]; then
    source "$HOME/miniconda3/etc/profile.d/conda.sh"
elif command -v conda >/dev/null 2>&1; then
    # Try to find conda in PATH
    CONDA_PATH=$(which conda)
    if [[ -n "$CONDA_PATH" ]]; then
        CONDA_DIR=$(dirname "$CONDA_PATH")
        if [[ -f "$CONDA_DIR/../etc/profile.d/conda.sh" ]]; then
            source "$CONDA_DIR/../etc/profile.d/conda.sh"
        fi
    fi
fi

# =============================================================================
# Zsh Plugins Configuration
# =============================================================================

# Load zsh plugins if they exist
if [[ -f "$ZSH_AUTOSUGGESTIONS_PATH" ]]; then
    source "$ZSH_AUTOSUGGESTIONS_PATH"
else
    echo "zsh-autosuggestions not found at: $ZSH_AUTOSUGGESTIONS_PATH" >&2
    # Try Oh My Zsh custom plugins
    if [[ -d "$ZSH/custom/plugins/zsh-autosuggestions" ]]; then
        source "$ZSH/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    fi
fi

if [[ -f "$ZSH_SYNTAX_HIGHLIGHTING_PATH" ]]; then
    source "$ZSH_SYNTAX_HIGHLIGHTING_PATH"
else
    echo "zsh-syntax-highlighting not found at: $ZSH_SYNTAX_HIGHLIGHTING_PATH" >&2
    # Try Oh My Zsh custom plugins
    if [[ -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]]; then
        source "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    fi
fi

# Add completions to fpath
if [[ -d "$ZSH_COMPLETIONS_PATH" ]]; then
    fpath=("$ZSH_COMPLETIONS_PATH" $fpath)
fi

# =============================================================================
# Additional Tools
# =============================================================================

# FZF
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
fi

# =============================================================================
# Powerlevel10k Configuration
# =============================================================================

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =============================================================================
# User Configuration
# =============================================================================

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='vim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# =============================================================================
# Environment Variables
# =============================================================================

# Language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History configuration
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# =============================================================================
# Final Configuration
# =============================================================================

# Reload completions
autoload -U compinit
compinit

echo "Zsh configuration loaded successfully for $OS on $ARCH" >&2 