#!/bin/bash

# ========== 终端工具配置集合 - 一键安装脚本 ==========
# 作者: AI Assistant
# 版本: v1.0.0
# 日期: 2024-07-19

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查系统类型
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get &> /dev/null; then
            echo "ubuntu"
        elif command -v yum &> /dev/null; then
            echo "centos"
        else
            echo "linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# 安装基础工具
install_basic_tools() {
    local os_type=$(detect_os)
    
    log_info "检测到操作系统: $os_type"
    
    case $os_type in
        "macos")
            log_info "使用 Homebrew 安装工具..."
            if ! command -v brew &> /dev/null; then
                log_error "Homebrew 未安装，请先安装 Homebrew"
                exit 1
            fi
            brew install zsh nvim tmux git curl
            ;;
        "ubuntu")
            log_info "使用 apt 安装工具..."
            sudo apt update
            sudo apt install -y zsh nvim tmux git curl
            ;;
        "centos")
            log_info "使用 yum 安装工具..."
            sudo yum install -y epel-release
            sudo yum install -y zsh nvim tmux git curl
            ;;
        *)
            log_warning "未知操作系统，请手动安装基础工具"
            ;;
    esac
}

# 安装 Oh My Zsh
install_oh_my_zsh() {
    log_info "安装 Oh My Zsh..."
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh My Zsh 安装完成"
    else
        log_info "Oh My Zsh 已存在，跳过安装"
    fi
}

# 安装 Powerlevel10k
install_powerlevel10k() {
    log_info "安装 Powerlevel10k 主题..."
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
        log_success "Powerlevel10k 安装完成"
    else
        log_info "Powerlevel10k 已存在，跳过安装"
    fi
}

# 安装 Zsh 插件
install_zsh_plugins() {
    log_info "安装 Zsh 插件..."
    
    local plugins=(
        "zsh-autosuggestions:https://github.com/zsh-users/zsh-autosuggestions"
        "zsh-syntax-highlighting:https://github.com/zsh-users/zsh-syntax-highlighting.git"
    )
    
    for plugin in "${plugins[@]}"; do
        IFS=':' read -r name url <<< "$plugin"
        local plugin_dir="$HOME/.oh-my-zsh/custom/plugins/$name"
        
        if [ ! -d "$plugin_dir" ]; then
            log_info "安装插件: $name"
            git clone "$url" "$plugin_dir"
        else
            log_info "插件 $name 已存在，跳过安装"
        fi
    done
    
    log_success "Zsh 插件安装完成"
}

# 安装 vim-plug
install_vim_plug() {
    log_info "安装 vim-plug..."
    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        log_success "vim-plug 安装完成"
    else
        log_info "vim-plug 已存在，跳过安装"
    fi
}

# 安装 TPM
install_tpm() {
    log_info "安装 TPM (Tmux Plugin Manager)..."
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        log_success "TPM 安装完成"
    else
        log_info "TPM 已存在，跳过安装"
    fi
}

# 复制配置文件
copy_configs() {
    log_info "复制配置文件..."
    
    # 获取脚本所在目录
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local project_root="$(dirname "$(dirname "$script_dir")")"
    
    # 复制配置文件
    cp "$project_root/configs/shell/.zshrc" "$HOME/.zshrc"
    cp "$project_root/configs/shell/.bashrc" "$HOME/.bashrc"
    cp "$project_root/configs/editor/.vimrc" "$HOME/.vimrc"
    cp "$project_root/configs/terminal/.tmux.conf" "$HOME/.tmux.conf"
    
    # 复制 Neovim 配置
    mkdir -p "$HOME/.config"
    cp -r "$project_root/configs/editor/nvim" "$HOME/.config/"
    
    log_success "配置文件复制完成"
}

# 安装插件
install_plugins() {
    log_info "安装编辑器插件..."
    
    # 安装 Vim 插件
    if command -v vim &> /dev/null; then
        log_info "安装 Vim 插件..."
        vim +PlugInstall +qall
    fi
    
    # 安装 Neovim 插件
    if command -v nvim &> /dev/null; then
        log_info "安装 Neovim 插件..."
        nvim --headless -c "Lazy install" -c "qa"
    fi
    
    log_success "插件安装完成"
}

# 设置默认 Shell
set_default_shell() {
    log_info "设置 Zsh 为默认 Shell..."
    if command -v zsh &> /dev/null; then
        chsh -s $(which zsh)
        log_success "默认 Shell 已设置为 Zsh"
        log_warning "请重新登录或重启终端以生效"
    else
        log_error "Zsh 未安装，无法设置默认 Shell"
    fi
}

# 显示完成信息
show_completion_info() {
    echo
    log_success "安装完成！"
    echo
    echo "🎉 所有工具已成功安装和配置"
    echo
    echo "📋 已安装的工具："
    echo "  ✅ Zsh + Oh My Zsh + Powerlevel10k"
    echo "  ✅ Vim + vim-plug"
    echo "  ✅ Neovim + Lazy.nvim"
    echo "  ✅ Tmux + TPM"
    echo "  ✅ Bash 增强配置"
    echo
    echo "🚀 下一步："
    echo "  1. 重新登录或重启终端"
    echo "  2. 运行 'p10k configure' 配置 Powerlevel10k"
    echo "  3. 在 tmux 中按 'Ctrl + a, I' 安装 tmux 插件"
    echo "  4. 查看文档了解详细使用方法"
    echo
    echo "📚 文档位置："
    echo "  📖 主文档: docs/README.md"
    echo "  🔧 Shell: docs/shell/"
    echo "  📝 编辑器: docs/editor/"
    echo "  🖥️ 终端: docs/terminal/"
    echo
}

# 主函数
main() {
    echo "🚀 开始安装终端工具配置集合..."
    echo
    
    # 检查是否在正确的目录
    if [ ! -f "configs/shell/.zshrc" ]; then
        log_error "请在项目根目录运行此脚本"
        exit 1
    fi
    
    # 执行安装步骤
    install_basic_tools
    install_oh_my_zsh
    install_powerlevel10k
    install_zsh_plugins
    install_vim_plug
    install_tpm
    copy_configs
    install_plugins
    set_default_shell
    
    show_completion_info
}

# 运行主函数
main "$@" 