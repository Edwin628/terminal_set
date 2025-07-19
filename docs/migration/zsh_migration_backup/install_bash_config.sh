#!/bin/bash

# 🚀 Bash 配置安装脚本
# 作者: AI Assistant
# 描述: 安装增强版 Bash 配置

set -e

echo "🚀 开始安装 Bash 配置..."
echo "================================"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

# 检查系统
check_system() {
    log_info "检查系统环境..."
    
    # 检查是否为 Linux
    if [[ "$OSTYPE" != "linux-gnu"* ]]; then
        log_warning "检测到非 Linux 系统: $OSTYPE"
    fi
    
    # 检查 bash 版本
    local bash_version=$(bash --version | head -1 | cut -d' ' -f4)
    log_info "Bash 版本: $bash_version"
    
    log_success "系统检查通过"
}

# 备份现有配置
backup_config() {
    log_info "备份现有配置..."
    
    if [[ -f "$HOME/.bashrc" ]]; then
        local backup_file="$HOME/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$HOME/.bashrc" "$backup_file"
        log_success "已备份现有 .bashrc 到: $backup_file"
    fi
    
    if [[ -f "$HOME/.bash_profile" ]]; then
        local backup_file="$HOME/.bash_profile.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$HOME/.bash_profile" "$backup_file"
        log_success "已备份现有 .bash_profile 到: $backup_file"
    fi
}

# 安装配置文件
install_config() {
    log_info "安装 Bash 配置..."
    
    # 复制 .bashrc
    if [[ -f ".bashrc" ]]; then
        cp .bashrc "$HOME/.bashrc"
        log_success "已安装 .bashrc"
    else
        log_error "未找到 .bashrc 文件"
        exit 1
    fi
    
    # 创建 .bash_profile（如果不存在）
    if [[ ! -f "$HOME/.bash_profile" ]]; then
        cat > "$HOME/.bash_profile" << 'EOF'
# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
EOF
        log_success "已创建 .bash_profile"
    fi
}

# 安装 bash-completion
install_bash_completion() {
    log_info "安装 bash-completion..."
    
    # 检测包管理器并安装 bash-completion
    if command -v apt-get &> /dev/null; then
        log_info "检测到 apt 包管理器"
        sudo apt-get update
        sudo apt-get install -y bash-completion
    elif command -v yum &> /dev/null; then
        log_info "检测到 yum 包管理器"
        sudo yum install -y bash-completion
    elif command -v dnf &> /dev/null; then
        log_info "检测到 dnf 包管理器"
        sudo dnf install -y bash-completion
    elif command -v pacman &> /dev/null; then
        log_info "检测到 pacman 包管理器"
        sudo pacman -S --noconfirm bash-completion
    else
        log_warning "未检测到支持的包管理器，请手动安装 bash-completion"
    fi
    
    log_success "bash-completion 安装完成"
}

# 创建测试脚本
create_test_script() {
    log_info "创建测试脚本..."
    
    cat > test_bash_config.sh << 'EOF'
#!/bin/bash
echo "🧪 Bash 配置测试脚本"
echo "===================="

echo "1. 检查 Bash 版本..."
bash --version

echo -e "\n2. 检查配置文件..."
if [[ -f "$HOME/.bashrc" ]]; then
    echo "✅ .bashrc 存在"
    echo "   大小: $(wc -c < "$HOME/.bashrc") 字节"
    echo "   行数: $(wc -l < "$HOME/.bashrc") 行"
else
    echo "❌ .bashrc 不存在"
fi

if [[ -f "$HOME/.bash_profile" ]]; then
    echo "✅ .bash_profile 存在"
else
    echo "❌ .bash_profile 不存在"
fi

echo -e "\n3. 检查 bash-completion..."
if [[ -f /etc/bash_completion ]] || [[ -f /usr/share/bash-completion/bash_completion ]]; then
    echo "✅ bash-completion 已安装"
else
    echo "❌ bash-completion 未安装"
fi

echo -e "\n4. 测试别名..."
echo "测试 ll 别名:"
alias ll 2>/dev/null || echo "ll 别名未定义"

echo -e "\n5. 测试函数..."
echo "测试 sysinfo 函数:"
type sysinfo 2>/dev/null || echo "sysinfo 函数未定义"

echo -e "\n6. 启动 Bash 进行测试..."
echo "在 Bash 中测试以下功能:"
echo "  - 彩色提示符"
echo "  - 别名功能 (ll, la, ..)"
echo "  - 函数功能 (sysinfo, help)"
echo "  - 历史记录搜索 (上下箭头)"
echo "  - 输入 exit 退出"
echo ""
echo "按 Enter 启动 Bash..."
read
bash
EOF

    chmod +x test_bash_config.sh
    log_success "测试脚本已创建: test_bash_config.sh"
}

# 显示使用说明
show_usage() {
    echo ""
    echo "🎉 安装完成！"
    echo "===================="
    echo "请执行以下步骤:"
    echo "1. 重新登录或运行: exec bash"
    echo "2. 运行测试脚本: ./test_bash_config.sh"
    echo "3. 输入 help 查看可用命令"
    echo ""
    echo "主要功能:"
    echo "- 彩色提示符和输出"
    echo "- 丰富的别名和函数"
    echo "- 历史记录增强"
    echo "- 自动补全支持"
    echo "- 系统信息工具"
    echo ""
    echo "配置文件位置:"
    echo "- .bashrc: $HOME/.bashrc"
    echo "- .bash_profile: $HOME/.bash_profile"
}

# 主函数
main() {
    echo "🚀 Bash 配置安装脚本"
    echo "===================="
    echo "此脚本将安装增强版 Bash 配置"
    echo ""
    
    read -p "是否继续安装? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "安装已取消"
        exit 0
    fi
    
    check_system
    backup_config
    install_config
    install_bash_completion
    create_test_script
    show_usage
}

# 运行主函数
main "$@" 