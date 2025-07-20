#!/bin/bash

# Bash 插件安装脚本
# 安装类似 Zsh 插件的 Bash 功能

echo "🐚 安装 Bash 插件和增强功能"
echo "================================"

# 检测操作系统
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    PACKAGE_MANAGER="brew"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
    if command -v apt >/dev/null 2>&1; then
        PACKAGE_MANAGER="apt"
    elif command -v yum >/dev/null 2>&1; then
        PACKAGE_MANAGER="yum"
    elif command -v dnf >/dev/null 2>&1; then
        PACKAGE_MANAGER="dnf"
    elif command -v pacman >/dev/null 2>&1; then
        PACKAGE_MANAGER="pacman"
    else
        PACKAGE_MANAGER="unknown"
    fi
else
    OS="unknown"
    PACKAGE_MANAGER="unknown"
fi

echo "检测到系统: $OS"
echo "包管理器: $PACKAGE_MANAGER"

# 创建插件目录
mkdir -p ~/.bash_plugins
echo "✅ 创建插件目录: ~/.bash_plugins"

# 安装基础工具
install_basic_tools() {
    echo "📦 安装基础工具..."
    
    case $PACKAGE_MANAGER in
        "brew")
            brew install fzf ripgrep bat fd tree htop
            ;;
        "apt")
            sudo apt update
            sudo apt install -y fzf ripgrep bat fd-find tree htop
            ;;
        "yum"|"dnf")
            sudo $PACKAGE_MANAGER install -y fzf ripgrep bat fd-find tree htop
            ;;
        "pacman")
            sudo pacman -S --noconfirm fzf ripgrep bat fd tree htop
            ;;
        *)
            echo "⚠️  请手动安装: fzf, ripgrep, bat, fd, tree, htop"
            ;;
    esac
}

# 安装 bash-preexec
install_bash_preexec() {
    echo "🔧 安装 bash-preexec..."
    
    if [ ! -f ~/.bash-preexec.sh ]; then
        curl -L https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
        echo "✅ bash-preexec 已安装"
    else
        echo "✅ bash-preexec 已存在"
    fi
}

# 安装 bash-it (可选)
install_bash_it() {
    echo "🎨 安装 bash-it (可选)..."
    
    if [ ! -d ~/.bash_it ]; then
        git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
        ~/.bash_it/install.sh --silent
        echo "✅ bash-it 已安装"
        echo "💡 运行 'bash-it enable plugin <plugin_name>' 来启用插件"
    else
        echo "✅ bash-it 已存在"
    fi
}

# 安装 fzf 配置
install_fzf_config() {
    echo "🔍 配置 fzf..."
    
    # 下载 fzf 配置
    if [ ! -f ~/.fzf.bash ]; then
        curl -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash -o ~/.fzf.bash
        curl -L https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash -o ~/.fzf-key-bindings.bash
        echo "✅ fzf 配置已下载"
    else
        echo "✅ fzf 配置已存在"
    fi
}

# 安装 bash-completion
install_bash_completion() {
    echo "⌨️  安装 bash-completion..."
    
    case $PACKAGE_MANAGER in
        "brew")
            brew install bash-completion@2
            ;;
        "apt")
            sudo apt install -y bash-completion
            ;;
        "yum"|"dnf")
            sudo $PACKAGE_MANAGER install -y bash-completion
            ;;
        "pacman")
            sudo pacman -S --noconfirm bash-completion
            ;;
        *)
            echo "⚠️  请手动安装 bash-completion"
            ;;
    esac
}

# 安装 Git 自动补全
install_git_completion() {
    echo "📝 安装 Git 自动补全..."
    
    if [ ! -f ~/.git-completion.bash ]; then
        curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
        echo "✅ Git 自动补全已安装"
    else
        echo "✅ Git 自动补全已存在"
    fi
}

# 创建自定义插件
create_custom_plugins() {
    echo "🔧 创建自定义插件..."
    
    # 创建目录跳转插件
    cat > ~/.bash_plugins/autojump.sh << 'EOF'
# 简单的目录跳转功能
autojump() {
    local dir
    if [ -z "$1" ]; then
        cd ~
    elif [ -d "$1" ]; then
        cd "$1"
    else
        # 搜索历史目录
        dir=$(find ~ -type d -name "*$1*" 2>/dev/null | head -1)
        if [ -n "$dir" ]; then
            cd "$dir"
        else
            echo "目录未找到: $1"
        fi
    fi
}

alias j='autojump'
EOF

    # 创建历史搜索插件
    cat > ~/.bash_plugins/history-search.sh << 'EOF'
# 历史搜索功能
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'
EOF

    # 创建语法高亮插件
    cat > ~/.bash_plugins/syntax-highlight.sh << 'EOF'
# 简单的语法高亮
if [ -f ~/.bash-preexec.sh ]; then
    source ~/.bash-preexec.sh
    
    preexec() {
        echo -e "\033[1;33m$1\033[0m"
    }
fi
EOF

    echo "✅ 自定义插件已创建"
}

# 备份现有配置
backup_config() {
    echo "💾 备份现有配置..."
    
    if [ -f ~/.bashrc ]; then
        cp ~/.bashrc ~/.bashrc.backup.$(date +%Y%m%d_%H%M%S)
        echo "✅ 已备份 ~/.bashrc"
    fi
    
    if [ -f ~/.bash_profile ]; then
        cp ~/.bash_profile ~/.bash_profile.backup.$(date +%Y%m%d_%H%M%S)
        echo "✅ 已备份 ~/.bash_profile"
    fi
}

# 安装增强配置
install_enhanced_config() {
    echo "📋 安装增强配置..."
    
    # 复制增强的 bashrc
    cp configs/shell/.bashrc_enhanced ~/.bashrc_enhanced
    
    # 创建新的 .bashrc
    cat > ~/.bashrc << 'EOF'
# 加载增强的 Bash 配置
if [ -f ~/.bashrc_enhanced ]; then
    . ~/.bashrc_enhanced
fi

# 加载本地配置
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
EOF

    # 确保 .bash_profile 加载 .bashrc
    if [ ! -f ~/.bash_profile ]; then
        cat > ~/.bash_profile << 'EOF'
# 加载 .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
EOF
    else
        # 检查是否已经包含 .bashrc
        if ! grep -q "\. ~/.bashrc" ~/.bash_profile; then
            echo "" >> ~/.bash_profile
            echo "# 加载 .bashrc" >> ~/.bash_profile
            echo "if [ -f ~/.bashrc ]; then" >> ~/.bash_profile
            echo "    . ~/.bashrc" >> ~/.bash_profile
            echo "fi" >> ~/.bash_profile
        fi
    fi
    
    echo "✅ 增强配置已安装"
}

# 主安装流程
main() {
    backup_config
    install_basic_tools
    install_bash_completion
    install_bash_preexec
    install_fzf_config
    install_git_completion
    create_custom_plugins
    install_enhanced_config
    
    echo ""
    echo "🎉 Bash 插件安装完成！"
    echo ""
    echo "📚 已安装的功能："
    echo "  ✅ 自动补全 (bash-completion)"
    echo "  ✅ 历史搜索 (上下箭头)"
    echo "  ✅ 模糊搜索 (fzf)"
    echo "  ✅ 目录跳转 (j 命令)"
    echo "  ✅ 语法高亮 (bash-preexec)"
    echo "  ✅ Git 自动补全"
    echo "  ✅ 彩色提示符"
    echo "  ✅ 实用别名"
    echo ""
    echo "🔄 请重新启动终端或运行："
    echo "  source ~/.bashrc"
    echo ""
    echo "💡 可用命令："
    echo "  j <目录名>     - 快速跳转到目录"
    echo "  Ctrl+R        - 搜索历史命令"
    echo "  Ctrl+T        - 搜索目录"
    echo "  Ctrl+F        - 搜索文件"
    echo "  dh            - 显示目录历史"
    echo "  extract <文件> - 解压文件"
    echo "  copypath      - 复制当前路径"
}

# 运行安装
main 