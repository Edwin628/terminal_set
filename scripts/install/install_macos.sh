#!/bin/bash

# macOS 专用安装脚本
echo "🚀 开始安装 macOS 终端工具..."

# 检查是否安装了 Homebrew
if ! command -v brew &> /dev/null; then
    echo "📦 安装 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 安装基础工具
echo "📦 安装基础工具..."
brew install git curl wget tree htop fzf ripgrep bat fd tmux vim

# 安装 Oh My Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    echo "🐚 安装 Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 安装 Powerlevel10k 主题
if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
    echo "🎨 安装 Powerlevel10k 主题..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

# 安装 zsh 插件
echo "🔌 安装 zsh 插件..."
mkdir -p "$HOME/.oh-my-zsh/custom/plugins"

# zsh-autosuggestions
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
fi

# zsh-completions
if [[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" ]]; then
    git clone https://github.com/zsh-users/zsh-completions "$HOME/.oh-my-zsh/custom/plugins/zsh-completions"
fi

# 安装 TPM (Tmux Plugin Manager)
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "🔧 安装 Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# 备份现有配置
echo "💾 备份现有配置..."
if [[ -f "$HOME/.zshrc" ]]; then
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d_%H%M%S)"
fi
if [[ -f "$HOME/.tmux.conf" ]]; then
    cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup.$(date +%Y%m%d_%H%M%S)"
fi
if [[ -f "$HOME/.vimrc" ]]; then
    cp "$HOME/.vimrc" "$HOME/.vimrc.backup.$(date +%Y%m%d_%H%M%S)"
fi

# 复制配置文件
echo "📋 安装配置文件..."
cp configs/shell/.zshrc_macos ~/.zshrc
cp configs/terminal/.tmux.conf ~/.tmux.conf
cp configs/editor/.vimrc ~/.vimrc

# 修复权限
echo "🔒 修复权限..."
chmod -R g-w ~/.oh-my-zsh

echo "✅ macOS 安装完成！"
echo "🔄 请重启终端或运行: source ~/.zshrc"
echo "🎨 配置 Powerlevel10k: p10k configure" 