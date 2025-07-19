# 🚀 跨平台部署指南

本指南将帮助你在不同的操作系统上部署终端工具配置。

## 📋 支持的操作系统

- **macOS** (Intel & Apple Silicon)
- **Linux** (Ubuntu, CentOS, Fedora, Arch Linux, openSUSE)
- **Windows** (通过 WSL 或 Git Bash)

## 🛠️ 快速部署

### 方法一：一键安装脚本

```bash
# 克隆项目
git clone <your-repo-url>
cd terminal_set

# 运行通用安装脚本
./scripts/install/install_universal.sh
```

### 方法二：手动安装

#### 1. 安装 Oh My Zsh

```bash
# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

#### 2. 安装 Powerlevel10k 主题

```bash
# 安装 Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

#### 3. 安装 Zsh 插件

```bash
# 创建插件目录
mkdir -p ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins

# 安装 zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# 安装 zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 安装 zsh-completions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

#### 4. 安装配置文件

```bash
# 复制通用 .zshrc
cp configs/shell/.zshrc_universal ~/.zshrc

# 复制 tmux 配置
cp configs/terminal/.tmux.conf ~/.tmux.conf

# 复制 vim 配置
cp configs/editor/.vimrc ~/.vimrc
```

## 🔧 平台特定配置

### macOS

#### 安装 Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### 安装开发工具

```bash
brew install git curl wget tree htop fzf ripgrep bat fd tmux vim
```

### Linux

#### Ubuntu/Debian

```bash
sudo apt update
sudo apt install -y git curl wget tree htop fzf ripgrep bat fd tmux vim zsh
```

#### CentOS/RHEL/Fedora

```bash
# CentOS/RHEL
sudo yum install -y git curl wget tree htop tmux vim zsh

# Fedora
sudo dnf install -y git curl wget tree htop fzf ripgrep bat fd tmux vim zsh
```

#### Arch Linux

```bash
sudo pacman -S --noconfirm git curl wget tree htop fzf ripgrep bat fd tmux vim zsh
```

### Windows

#### 通过 WSL

1. 安装 WSL2
2. 安装 Ubuntu 发行版
3. 按照 Linux 步骤进行配置

#### 通过 Git Bash

1. 安装 Git for Windows
2. 使用 Git Bash 终端
3. 按照 Linux 步骤进行配置

## 🐛 故障排除

### 常见问题

#### 1. Powerlevel10k 警告

如果看到 Powerlevel10k 的 instant prompt 警告，可以：

```bash
# 方法一：配置 Powerlevel10k
p10k configure

# 方法二：禁用 instant prompt
echo 'typeset -g POWERLEVEL9K_INSTANT_PROMPT=off' >> ~/.zshrc
```

#### 2. 插件路径问题

如果插件无法加载，检查插件路径：

```bash
# 检查插件目录
ls -la ~/.oh-my-zsh/custom/plugins/

# 手动设置插件路径
echo 'source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
echo 'source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
```

#### 3. 权限问题

```bash
# 确保脚本有执行权限
chmod +x scripts/install/install_universal.sh

# 确保配置文件可读
chmod 644 ~/.zshrc ~/.tmux.conf ~/.vimrc
```

#### 4. 网络问题

如果网络连接有问题，可以手动下载插件：

```bash
# 手动下载插件
cd ~/.oh-my-zsh/custom/plugins
wget https://github.com/zsh-users/zsh-autosuggestions/archive/refs/heads/master.zip
unzip master.zip
mv zsh-autosuggestions-master zsh-autosuggestions
rm master.zip
```

## 🔄 更新配置

### 更新所有工具

```bash
# 更新 Oh My Zsh
omz update

# 更新插件
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull

# 更新 Powerlevel10k
cd ~/.oh-my-zsh/custom/themes/powerlevel10k && git pull
```

### 重新加载配置

```bash
# 重新加载 zsh 配置
source ~/.zshrc

# 重新加载 tmux 配置
tmux source ~/.tmux.conf
```

## 📦 包管理器支持

### macOS
- **Homebrew**: 主要包管理器
- **MacPorts**: 替代选择

### Linux
- **apt**: Ubuntu, Debian
- **yum/dnf**: CentOS, RHEL, Fedora
- **pacman**: Arch Linux
- **zypper**: openSUSE

### Windows
- **Chocolatey**: Windows 包管理器
- **Scoop**: 轻量级包管理器
- **WSL**: 使用 Linux 包管理器

## 🔒 安全注意事项

1. **备份现有配置**: 安装前自动备份现有配置文件
2. **权限检查**: 确保脚本和配置文件有正确的权限
3. **网络安全**: 使用 HTTPS 下载插件和工具
4. **依赖验证**: 验证下载的工具和插件的完整性

## 📞 获取帮助

如果遇到问题：

1. 检查 [故障排除](#故障排除) 部分
2. 查看项目文档
3. 提交 Issue 到项目仓库
4. 联系维护者

## 🎯 下一步

安装完成后：

1. 重启终端或运行 `source ~/.zshrc`
2. 运行 `p10k configure` 配置 Powerlevel10k
3. 安装 tmux 插件：`tmux source ~/.tmux.conf`
4. 根据需要自定义配置

---

**注意**: 本配置适用于大多数 Unix-like 系统。如果在特定环境中遇到问题，请参考相应的平台文档。 