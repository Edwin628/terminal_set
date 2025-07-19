#!/bin/bash

# ========== 终端工具配置集合 - 安装检查脚本 ==========
# 作者: AI Assistant
# 版本: v1.0.0
# 日期: 2024-07-19

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

# 检查工具是否安装
check_tool() {
    local tool_name="$1"
    local tool_command="$2"
    local version_command="$3"
    
    if command -v "$tool_command" &> /dev/null; then
        if [ -n "$version_command" ]; then
            local version=$($version_command 2>/dev/null | head -1)
            log_success "$tool_name 已安装: $version"
        else
            log_success "$tool_name 已安装"
        fi
        return 0
    else
        log_error "$tool_name 未安装"
        return 1
    fi
}

# 检查文件是否存在
check_file() {
    local file_path="$1"
    local description="$2"
    
    if [ -f "$file_path" ]; then
        log_success "$description 存在: $file_path"
        return 0
    else
        log_error "$description 不存在: $file_path"
        return 1
    fi
}

# 检查目录是否存在
check_directory() {
    local dir_path="$1"
    local description="$2"
    
    if [ -d "$dir_path" ]; then
        log_success "$description 存在: $dir_path"
        return 0
    else
        log_error "$description 不存在: $dir_path"
        return 1
    fi
}

# 检查基础工具
check_basic_tools() {
    echo "=== 基础工具检查 ==="
    
    local tools=(
        "Zsh:zsh:zsh --version"
        "Bash:bash:bash --version"
        "Neovim:nvim:nvim --version"
        "Vim:vim:vim --version"
        "Tmux:tmux:tmux -V"
        "Git:git:git --version"
        "Curl:curl:curl --version"
    )
    
    local all_installed=true
    
    for tool in "${tools[@]}"; do
        IFS=':' read -r name command version_cmd <<< "$tool"
        if ! check_tool "$name" "$command" "$version_cmd"; then
            all_installed=false
        fi
    done
    
    echo
    return $([ "$all_installed" = true ] && echo 0 || echo 1)
}

# 检查配置文件
check_config_files() {
    echo "=== 配置文件检查 ==="
    
    local configs=(
        "$HOME/.zshrc:Zsh 配置文件"
        "$HOME/.bashrc:Bash 配置文件"
        "$HOME/.vimrc:Vim 配置文件"
        "$HOME/.tmux.conf:Tmux 配置文件"
    )
    
    local all_exist=true
    
    for config in "${configs[@]}"; do
        IFS=':' read -r path description <<< "$config"
        if ! check_file "$path" "$description"; then
            all_exist=false
        fi
    done
    
    # 检查 Neovim 配置目录
    if ! check_directory "$HOME/.config/nvim" "Neovim 配置目录"; then
        all_exist=false
    fi
    
    echo
    return $([ "$all_exist" = true ] && echo 0 || echo 1)
}

# 检查插件
check_plugins() {
    echo "=== 插件检查 ==="
    
    local plugins=(
        "$HOME/.oh-my-zsh:Oh My Zsh"
        "$HOME/.oh-my-zsh/custom/themes/powerlevel10k:Powerlevel10k 主题"
        "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions:zsh-autosuggestions 插件"
        "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting:zsh-syntax-highlighting 插件"
        "$HOME/.vim/autoload:Vim 插件目录"
        "$HOME/.tmux/plugins/tpm:TPM 插件管理器"
    )
    
    local all_exist=true
    
    for plugin in "${plugins[@]}"; do
        IFS=':' read -r path description <<< "$plugin"
        if ! check_directory "$path" "$description"; then
            all_exist=false
        fi
    done
    
    echo
    return $([ "$all_exist" = true ] && echo 0 || echo 1)
}

# 检查功能
check_functionality() {
    echo "=== 功能检查 ==="
    
    # 检查 Zsh 是否为默认 Shell
    local current_shell=$(echo $SHELL)
    if [[ "$current_shell" == *"zsh" ]]; then
        log_success "Zsh 是当前默认 Shell: $current_shell"
    else
        log_warning "Zsh 不是当前默认 Shell: $current_shell"
    fi
    
    # 检查 Oh My Zsh 是否正常工作
    if [ -n "$ZSH_VERSION" ]; then
        log_success "当前正在使用 Zsh: $ZSH_VERSION"
    else
        log_warning "当前未使用 Zsh"
    fi
    
    # 检查 Powerlevel10k 是否加载
    if [ -f "$HOME/.p10k.zsh" ]; then
        log_success "Powerlevel10k 配置文件存在"
    else
        log_warning "Powerlevel10k 配置文件不存在"
    fi
    
    echo
}

# 检查系统信息
check_system_info() {
    echo "=== 系统信息 ==="
    
    # 操作系统
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v lsb_release &> /dev/null; then
            log_info "操作系统: $(lsb_release -d | cut -f2)"
        else
            log_info "操作系统: Linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        log_info "操作系统: macOS $(sw_vers -productVersion)"
    else
        log_info "操作系统: $OSTYPE"
    fi
    
    # 架构
    log_info "架构: $(uname -m)"
    
    # 用户
    log_info "用户: $USER"
    log_info "主目录: $HOME"
    
    echo
}

# 生成报告
generate_report() {
    local basic_tools_ok=$1
    local config_files_ok=$2
    local plugins_ok=$3
    
    echo "=== 检查报告 ==="
    echo
    
    if [ $basic_tools_ok -eq 0 ] && [ $config_files_ok -eq 0 ] && [ $plugins_ok -eq 0 ]; then
        log_success "🎉 所有检查都通过！配置完整。"
        echo
        echo "✅ 基础工具: 已安装"
        echo "✅ 配置文件: 已配置"
        echo "✅ 插件: 已安装"
        echo
        echo "🚀 你现在可以："
        echo "  1. 使用 'zsh' 启动 Zsh"
        echo "  2. 使用 'nvim' 启动 Neovim"
        echo "  3. 使用 'vim' 启动 Vim"
        echo "  4. 使用 'tmux' 启动 Tmux"
        echo "  5. 运行 'p10k configure' 配置主题"
    else
        log_warning "⚠️  部分检查未通过，请查看上面的错误信息。"
        echo
        echo "❌ 需要修复的问题："
        [ $basic_tools_ok -ne 0 ] && echo "  - 基础工具未完全安装"
        [ $config_files_ok -ne 0 ] && echo "  - 配置文件缺失"
        [ $plugins_ok -ne 0 ] && echo "  - 插件未完全安装"
        echo
        echo "🔧 建议操作："
        echo "  1. 运行 'scripts/install/install_all.sh' 重新安装"
        echo "  2. 或查看 'docs/' 目录下的详细文档"
        echo "  3. 参考 'TOOLS_CHECKLIST.md' 进行故障排除"
    fi
    
    echo
}

# 主函数
main() {
    echo "🔍 开始检查终端工具配置集合..."
    echo
    
    # 检查系统信息
    check_system_info
    
    # 执行各项检查
    check_basic_tools
    local basic_tools_ok=$?
    
    check_config_files
    local config_files_ok=$?
    
    check_plugins
    local plugins_ok=$?
    
    check_functionality
    
    # 生成报告
    generate_report $basic_tools_ok $config_files_ok $plugins_ok
}

# 运行主函数
main "$@" 