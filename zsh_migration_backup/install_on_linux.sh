#!/bin/bash

# 🚀 ZSH 配置迁移脚本 - Linux 版本
# 作者: AI Assistant
# 描述: 自动安装和配置 zsh 环境

set -e  # 遇到错误时退出

echo "🚀 开始安装 ZSH 配置..."
echo "================================"

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

# 检查系统
check_system() {
    log_info "检查系统环境..."
    
    # 检查是否为 Linux
    if [[ "$OSTYPE" != "linux-gnu"* ]]; then
        log_error "此脚本仅适用于 Linux 系统"
        exit 1
    fi
    
    # 检查是否为 root 用户
    if [[ $EUID -eq 0 ]]; then
        log_warning "检测到 root 用户，建议使用普通用户运行"
    fi
    
    log_success "系统检查通过"
}

# 安装基础工具
install_basic_tools() {
    log_info "安装基础工具..."
    
    # 检测包管理器
    if command -v apt-get &> /dev/null; then
        log_info "检测到 apt 包管理器"
        sudo apt-get update
        sudo apt-get install -y zsh git curl wget build-essential
    elif command -v yum &> /dev/null; then
        log_info "检测到 yum 包管理器"
        sudo yum update -y
        sudo yum install -y zsh git curl wget gcc
    elif command -v dnf &> /dev/null; then
        log_info "检测到 dnf 包管理器"
        sudo dnf update -y
        sudo dnf install -y zsh git curl wget gcc
    elif command -v pacman &> /dev/null; then
        log_info "检测到 pacman 包管理器"
        sudo pacman -Syu --noconfirm
        sudo pacman -S --noconfirm zsh git curl wget base-devel
    else
        log_error "未检测到支持的包管理器"
        exit 1
    fi
    
    log_success "基础工具安装完成"
}

# 检查 zsh 版本
check_zsh_version() {
    log_info "检查 ZSH 版本..."
    
    local zsh_version=$(zsh --version | cut -d' ' -f2)
    local required_version="5.1"
    
    if [[ "$(printf '%s\n' "$required_version" "$zsh_version" | sort -V | head -n1)" == "$required_version" ]]; then
        log_success "ZSH 版本满足要求: $zsh_version"
    else
        log_error "ZSH 版本过低: $zsh_version，需要 $required_version 或更高版本"
        exit 1
    fi
}

# 安装 Oh My Zsh
install_oh_my_zsh() {
    log_info "安装 Oh My Zsh..."
    
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        log_warning "Oh My Zsh 已存在，跳过安装"
        return
    fi
    
    # 备份现有 zsh 配置
    if [[ -f "$HOME/.zshrc" ]]; then
        mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
        log_info "已备份现有 .zshrc"
    fi
    
    # 安装 Oh My Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    
    log_success "Oh My Zsh 安装完成"
}

# 安装 Powerlevel10k
install_powerlevel10k() {
    log_info "安装 Powerlevel10k 主题..."
    
    if [[ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
        log_warning "Powerlevel10k 已存在，跳过安装"
        return
    fi
    
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    
    log_success "Powerlevel10k 安装完成"
}

# 安装插件
install_plugins() {
    log_info "安装 ZSH 插件..."
    
    local plugins_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
    
    # zsh-autosuggestions
    if [[ ! -d "$plugins_dir/zsh-autosuggestions" ]]; then
        log_info "安装 zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions $plugins_dir/zsh-autosuggestions
    fi
    
    # zsh-syntax-highlighting
    if [[ ! -d "$plugins_dir/zsh-syntax-highlighting" ]]; then
        log_info "安装 zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $plugins_dir/zsh-syntax-highlighting
    fi
    
    # zsh-completions
    if [[ ! -d "$plugins_dir/zsh-completions" ]]; then
        log_info "安装 zsh-completions..."
        git clone https://github.com/zsh-users/zsh-completions $plugins_dir/zsh-completions
    fi
    
    # history-substring-search
    if [[ ! -d "$plugins_dir/zsh-history-substring-search" ]]; then
        log_info "安装 zsh-history-substring-search..."
        git clone https://github.com/zsh-users/zsh-history-substring-search $plugins_dir/zsh-history-substring-search
    fi
    
    # autojump
    if [[ ! -d "$plugins_dir/autojump" ]]; then
        log_info "安装 autojump..."
        git clone https://github.com/wting/autojump.git $plugins_dir/autojump
        cd $plugins_dir/autojump
        python3 install.py
        cd - > /dev/null
    fi
    
    log_success "插件安装完成"
}

# 复制配置文件
copy_config_files() {
    log_info "复制配置文件..."
    
    # 复制精简版 .zshrc
    if [[ -f ".zshrc" ]]; then
        cp .zshrc "$HOME/.zshrc"
        log_success "已复制精简版 .zshrc"
    else
        log_error "未找到 .zshrc 配置文件"
        exit 1
    fi
    
    # 复制 .p10k.zsh（如果存在）
    if [[ -f ".p10k.zsh" ]]; then
        cp .p10k.zsh "$HOME/.p10k.zsh"
        log_success "已复制 .p10k.zsh"
    else
        log_warning "未找到 .p10k.zsh，将使用默认配置"
    fi
}

# 安装字体
install_fonts() {
    log_info "安装 Nerd Fonts..."
    
    local font_dir="$HOME/.local/share/fonts"
    mkdir -p "$font_dir"
    
    # 下载并安装字体
    cd "$font_dir"
    
    # 下载 Hack Nerd Font
    if [[ ! -f "Hack Nerd Font Complete.ttf" ]]; then
        log_info "下载 Hack Nerd Font..."
        wget -O "Hack Nerd Font Complete.ttf" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf"
    fi
    
    # 刷新字体缓存
    if command -v fc-cache &> /dev/null; then
        fc-cache -fv
        log_success "字体缓存已更新"
    fi
    
    cd - > /dev/null
}

# 设置默认 shell
set_default_shell() {
    log_info "设置 ZSH 为默认 shell..."
    
    if [[ "$SHELL" != "/bin/zsh" ]]; then
        chsh -s $(which zsh)
        log_success "已设置 ZSH 为默认 shell，请重新登录生效"
    else
        log_info "ZSH 已经是默认 shell"
    fi
}

# 创建测试脚本
create_test_script() {
    log_info "创建测试脚本..."
    
    cat > test_zsh_config.sh << 'EOF'
#!/bin/bash
echo "🧪 ZSH 配置测试脚本"
echo "===================="

echo "1. 检查 ZSH 版本..."
zsh --version

echo -e "\n2. 检查 Oh My Zsh..."
if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "✅ Oh My Zsh 已安装"
else
    echo "❌ Oh My Zsh 未安装"
fi

echo -e "\n3. 检查 Powerlevel10k..."
if [[ -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
    echo "✅ Powerlevel10k 已安装"
else
    echo "❌ Powerlevel10k 未安装"
fi

echo -e "\n4. 检查插件..."
plugins=("zsh-autosuggestions" "zsh-syntax-highlighting" "zsh-completions" "zsh-history-substring-search" "autojump")
for plugin in "${plugins[@]}"; do
    if [[ -d "$HOME/.oh-my-zsh/custom/plugins/$plugin" ]]; then
        echo "✅ $plugin 已安装"
    else
        echo "❌ $plugin 未安装"
    fi
done

echo -e "\n5. 检查配置文件..."
if [[ -f "$HOME/.zshrc" ]]; then
    echo "✅ .zshrc 存在"
else
    echo "❌ .zshrc 不存在"
fi

if [[ -f "$HOME/.p10k.zsh" ]]; then
    echo "✅ .p10k.zsh 存在"
else
    echo "❌ .p10k.zsh 不存在"
fi

echo -e "\n6. 启动 ZSH 进行测试..."
echo "在 ZSH 中测试以下功能:"
echo "  - 自动建议 (输入命令时应该看到灰色建议)"
echo "  - 语法高亮 (命令应该有颜色)"
echo "  - 主题显示 (应该看到 Powerlevel10k 主题)"
echo "  - 输入 :q 退出"
echo ""
echo "按 Enter 启动 ZSH..."
read
zsh
EOF

    chmod +x test_zsh_config.sh
    log_success "测试脚本已创建: test_zsh_config.sh"
}

# 主函数
main() {
    echo "🚀 ZSH 配置迁移脚本"
    echo "===================="
    echo "此脚本将自动安装和配置 ZSH 环境"
    echo ""
    
    read -p "是否继续安装? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "安装已取消"
        exit 0
    fi
    
    check_system
    install_basic_tools
    check_zsh_version
    install_oh_my_zsh
    install_powerlevel10k
    install_plugins
    copy_config_files
    install_fonts
    set_default_shell
    create_test_script
    
    echo ""
    echo "🎉 安装完成！"
    echo "===================="
    echo "请执行以下步骤:"
    echo "1. 重新登录或运行: exec zsh"
    echo "2. 运行测试脚本: ./test_zsh_config.sh"
    echo "3. 如果字体显示异常，请安装 Nerd Fonts"
    echo ""
    echo "配置文件位置:"
    echo "- .zshrc: $HOME/.zshrc"
    echo "- .p10k.zsh: $HOME/.p10k.zsh"
    echo "- Oh My Zsh: $HOME/.oh-my-zsh"
}

# 运行主函数
main "$@" 