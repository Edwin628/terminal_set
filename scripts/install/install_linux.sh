#!/bin/bash

# Linux 专用安装脚本
echo "🚀 开始安装 Linux 终端工具..."

# 检测包管理器
if command -v apt &> /dev/null; then
    PACKAGE_MANAGER="apt"
    UPDATE_CMD="sudo apt update"
    INSTALL_CMD="sudo apt install -y"
elif command -v yum &> /dev/null; then
    PACKAGE_MANAGER="yum"
    UPDATE_CMD="sudo yum update -y"
    INSTALL_CMD="sudo yum install -y"
elif command -v dnf &> /dev/null; then
    PACKAGE_MANAGER="dnf"
    UPDATE_CMD="sudo dnf update -y"
    INSTALL_CMD="sudo dnf install -y"
elif command -v pacman &> /dev/null; then
    PACKAGE_MANAGER="pacman"
    UPDATE_CMD="sudo pacman -Sy"
    INSTALL_CMD="sudo pacman -S --noconfirm"
elif command -v zypper &> /dev/null; then
    PACKAGE_MANAGER="zypper"
    UPDATE_CMD="sudo zypper refresh"
    INSTALL_CMD="sudo zypper install -y"
else
    echo "❌ 未找到支持的包管理器"
    exit 1
fi

echo "📦 使用包管理器: $PACKAGE_MANAGER"

# 更新包列表
echo "🔄 更新包列表..."
$UPDATE_CMD

# 安装基础工具
echo "📦 安装基础工具..."
case $PACKAGE_MANAGER in
    "apt")
        $INSTALL_CMD git curl wget tree htop fzf ripgrep bat fd tmux vim zsh
        ;;
    "yum"|"dnf")
        $INSTALL_CMD git curl wget tree htop tmux vim zsh
        ;;
    "pacman")
        $INSTALL_CMD git curl wget tree htop fzf ripgrep bat fd tmux vim zsh
        ;;
    "zypper")
        $INSTALL_CMD git curl wget tree htop fzf ripgrep bat fd tmux vim zsh
        ;;
esac

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
cp configs/shell/.zshrc_linux ~/.zshrc
cp configs/terminal/.tmux.conf ~/.tmux.conf
cp configs/editor/.vimrc ~/.vimrc

# 修复权限
echo "🔒 修复权限..."
chmod -R g-w ~/.oh-my-zsh

# 设置 zsh 为默认 shell
if [[ "$SHELL" != "/bin/zsh" ]]; then
    echo "🐚 设置 zsh 为默认 shell..."
    chsh -s /bin/zsh
    echo "⚠️  请重新登录以使 zsh 成为默认 shell"
fi

echo "✅ Linux 安装完成！"
echo "🔄 请重启终端或运行: source ~/.zshrc"
echo "🎨 配置 Powerlevel10k: p10k configure" 