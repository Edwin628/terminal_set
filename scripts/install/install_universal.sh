#!/bin/bash

# =============================================================================
# Universal Installation Script for Terminal Tools
# =============================================================================
# This script automatically detects the operating system and installs
# the appropriate terminal tools and configurations.

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to detect operating system
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
        echo "windows"
    else
        echo "unknown"
    fi
}

# Function to detect package manager
detect_package_manager() {
    if command_exists brew; then
        echo "brew"
    elif command_exists apt; then
        echo "apt"
    elif command_exists yum; then
        echo "yum"
    elif command_exists dnf; then
        echo "dnf"
    elif command_exists pacman; then
        echo "pacman"
    elif command_exists zypper; then
        echo "zypper"
    else
        echo "unknown"
    fi
}

# Function to install package
install_package() {
    local package_manager="$1"
    local package="$2"
    
    case "$package_manager" in
        "brew")
            brew install "$package"
            ;;
        "apt")
            sudo apt update && sudo apt install -y "$package"
            ;;
        "yum")
            sudo yum install -y "$package"
            ;;
        "dnf")
            sudo dnf install -y "$package"
            ;;
        "pacman")
            sudo pacman -S --noconfirm "$package"
            ;;
        "zypper")
            sudo zypper install -y "$package"
            ;;
        *)
            print_error "Unknown package manager: $package_manager"
            return 1
            ;;
    esac
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        print_status "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My Zsh installed successfully"
    else
        print_status "Oh My Zsh already installed"
    fi
}

# Function to install Powerlevel10k theme
install_powerlevel10k() {
    if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
        print_status "Installing Powerlevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
        print_success "Powerlevel10k theme installed successfully"
    else
        print_status "Powerlevel10k theme already installed"
    fi
}

# Function to install zsh plugins
install_zsh_plugins() {
    local plugin_dir="$HOME/.oh-my-zsh/custom/plugins"
    
    # Create plugins directory if it doesn't exist
    mkdir -p "$plugin_dir"
    
    # Install zsh-autosuggestions
    if [[ ! -d "$plugin_dir/zsh-autosuggestions" ]]; then
        print_status "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir/zsh-autosuggestions"
        print_success "zsh-autosuggestions installed successfully"
    else
        print_status "zsh-autosuggestions already installed"
    fi
    
    # Install zsh-syntax-highlighting
    if [[ ! -d "$plugin_dir/zsh-syntax-highlighting" ]]; then
        print_status "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugin_dir/zsh-syntax-highlighting"
        print_success "zsh-syntax-highlighting installed successfully"
    else
        print_status "zsh-syntax-highlighting already installed"
    fi
    
    # Install zsh-completions
    if [[ ! -d "$plugin_dir/zsh-completions" ]]; then
        print_status "Installing zsh-completions..."
        git clone https://github.com/zsh-users/zsh-completions "$plugin_dir/zsh-completions"
        print_success "zsh-completions installed successfully"
    else
        print_status "zsh-completions already installed"
    fi
}

# Function to install tmux
install_tmux() {
    if ! command_exists tmux; then
        print_status "Installing tmux..."
        install_package "$PACKAGE_MANAGER" "tmux"
        print_success "tmux installed successfully"
    else
        print_status "tmux already installed"
    fi
}

# Function to install vim/neovim
install_vim() {
    if ! command_exists vim && ! command_exists nvim; then
        print_status "Installing vim..."
        install_package "$PACKAGE_MANAGER" "vim"
        print_success "vim installed successfully"
    else
        print_status "vim/neovim already installed"
    fi
}

# Function to install development tools
install_dev_tools() {
    local os="$1"
    local package_manager="$2"
    
    case "$os" in
        "macos")
            # Install Homebrew if not present
            if ! command_exists brew; then
                print_status "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                print_success "Homebrew installed successfully"
            fi
            
            # Install common development tools
            print_status "Installing development tools via Homebrew..."
            brew install git curl wget tree htop fzf ripgrep bat fd
            print_success "Development tools installed successfully"
            ;;
        "linux")
            # Install common development tools
            print_status "Installing development tools..."
            case "$package_manager" in
                "apt")
                    sudo apt update && sudo apt install -y git curl wget tree htop fzf ripgrep bat fd
                    ;;
                "yum"|"dnf")
                    install_package "$package_manager" "git curl wget tree htop fzf ripgrep bat fd"
                    ;;
                "pacman")
                    sudo pacman -S --noconfirm git curl wget tree htop fzf ripgrep bat fd
                    ;;
                "zypper")
                    sudo zypper install -y git curl wget tree htop fzf ripgrep bat fd
                    ;;
            esac
            print_success "Development tools installed successfully"
            ;;
        "windows")
            print_warning "Windows installation requires manual setup. Please install Git for Windows and WSL."
            ;;
    esac
}

# Function to backup existing configuration
backup_config() {
    local config_file="$1"
    local backup_file="$2"
    
    if [[ -f "$config_file" ]]; then
        print_status "Backing up existing configuration: $config_file"
        cp "$config_file" "$backup_file"
        print_success "Backup created: $backup_file"
    fi
}

# Function to install configuration files
install_configs() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local project_root="$(dirname "$(dirname "$script_dir")")"
    
    print_status "Installing configuration files..."
    
    # Backup existing .zshrc
    backup_config "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Install universal .zshrc
    if [[ -f "$project_root/configs/shell/.zshrc_universal" ]]; then
        cp "$project_root/configs/shell/.zshrc_universal" "$HOME/.zshrc"
        print_success "Universal .zshrc installed"
    else
        print_error "Universal .zshrc not found at: $project_root/configs/shell/.zshrc_universal"
    fi
    
    # Install tmux config
    if [[ -f "$project_root/configs/terminal/.tmux.conf" ]]; then
        backup_config "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$project_root/configs/terminal/.tmux.conf" "$HOME/.tmux.conf"
        print_success "tmux configuration installed"
    fi
    
    # Install vim config
    if [[ -f "$project_root/configs/editor/.vimrc" ]]; then
        backup_config "$HOME/.vimrc" "$HOME/.vimrc.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$project_root/configs/editor/.vimrc" "$HOME/.vimrc"
        print_success "vim configuration installed"
    fi
    
    # Create tmux plugin directory
    mkdir -p "$HOME/.tmux/plugins"
    
    # Install TPM (Tmux Plugin Manager)
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        print_status "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
        print_success "Tmux Plugin Manager installed"
    fi
}

# Function to install Node.js and NVM
install_nodejs() {
    if ! command_exists node; then
        print_status "Installing Node.js via NVM..."
        
        # Install NVM
        if [[ ! -d "$HOME/.nvm" ]]; then
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
            export NVM_DIR="$HOME/.nvm"
            [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
            [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        fi
        
        # Install latest LTS Node.js
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        nvm install --lts
        nvm use --lts
        nvm alias default node
        
        print_success "Node.js installed successfully"
    else
        print_status "Node.js already installed"
    fi
}

# Function to install Python and conda
install_python() {
    if ! command_exists python3 && ! command_exists conda; then
        print_status "Installing Python..."
        
        case "$OS" in
            "macos")
                brew install python
                ;;
            "linux")
                install_package "$PACKAGE_MANAGER" "python3 python3-pip"
                ;;
        esac
        
        print_success "Python installed successfully"
    else
        print_status "Python already installed"
    fi
}

# Function to install Go
install_go() {
    if ! command_exists go; then
        print_status "Installing Go..."
        
        case "$OS" in
            "macos")
                brew install go
                ;;
            "linux")
                # Download and install Go
                local go_version="1.21.0"
                local go_arch=""
                
                if [[ "$(uname -m)" == "x86_64" ]]; then
                    go_arch="amd64"
                elif [[ "$(uname -m)" == "aarch64" ]]; then
                    go_arch="arm64"
                else
                    go_arch="amd64"
                fi
                
                local go_tarball="go${go_version}.linux-${go_arch}.tar.gz"
                local go_url="https://go.dev/dl/${go_tarball}"
                
                cd /tmp
                wget "$go_url"
                sudo tar -C /usr/local -xzf "$go_tarball"
                rm "$go_tarball"
                ;;
        esac
        
        print_success "Go installed successfully"
    else
        print_status "Go already installed"
    fi
}

# Main installation function
main() {
    print_status "Starting universal installation..."
    
    # Detect OS and package manager
    OS=$(detect_os)
    PACKAGE_MANAGER=$(detect_package_manager)
    
    print_status "Detected OS: $OS"
    print_status "Detected package manager: $PACKAGE_MANAGER"
    
    if [[ "$OS" == "unknown" ]]; then
        print_error "Unsupported operating system"
        exit 1
    fi
    
    if [[ "$PACKAGE_MANAGER" == "unknown" ]]; then
        print_warning "No supported package manager detected"
    fi
    
    # Install core tools
    install_oh_my_zsh
    install_powerlevel10k
    install_zsh_plugins
    install_tmux
    install_vim
    install_dev_tools "$OS" "$PACKAGE_MANAGER"
    
    # Install development languages
    install_nodejs
    install_python
    install_go
    
    # Install configurations
    install_configs
    
    print_success "Installation completed successfully!"
    print_status "Please restart your terminal or run: source ~/.zshrc"
    print_status "For tmux plugins, run: tmux source ~/.tmux.conf"
}

# Run main function
main "$@" 