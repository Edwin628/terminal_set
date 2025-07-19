# 🚀 ZSH 配置手动迁移指南

## 📋 迁移前准备

### 1. 检查当前配置
```bash
# 检查 ZSH 版本
zsh --version

# 检查当前配置
ls -la ~/.zshrc ~/.p10k.zsh ~/.oh-my-zsh/
```

### 2. 备份重要文件
```bash
# 创建备份目录
mkdir -p ~/zsh_backup_$(date +%Y%m%d)

# 备份配置文件
cp ~/.zshrc ~/zsh_backup_$(date +%Y%m%d)/
cp ~/.p10k.zsh ~/zsh_backup_$(date +%Y%m%d)/ 2>/dev/null || echo "p10k.zsh 不存在"
```

## 🔧 Linux 系统安装步骤

### 步骤1: 安装基础工具

#### Ubuntu/Debian:
```bash
sudo apt update
sudo apt install -y zsh git curl wget build-essential
```

#### CentOS/RHEL:
```bash
sudo yum update -y
sudo yum install -y zsh git curl wget gcc
```

#### Fedora:
```bash
sudo dnf update -y
sudo dnf install -y zsh git curl wget gcc
```

#### Arch Linux:
```bash
sudo pacman -Syu
sudo pacman -S zsh git curl wget base-devel
```

### 步骤2: 检查 ZSH 版本
```bash
zsh --version
# 确保版本 >= 5.1
```

### 步骤3: 安装 Oh My Zsh
```bash
# 备份现有配置
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
fi

# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
```

### 步骤4: 安装 Powerlevel10k 主题
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### 步骤5: 安装插件

#### zsh-autosuggestions:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

#### zsh-syntax-highlighting:
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

#### zsh-completions:
```bash
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
```

#### history-substring-search:
```bash
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
```

#### autojump:
```bash
git clone https://github.com/wting/autojump.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autojump
cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autojump
python3 install.py
cd -
```

### 步骤6: 复制配置文件
```bash
# 复制 .zshrc
cp .zshrc ~/.zshrc

# 复制 .p10k.zsh（如果存在）
if [ -f .p10k.zsh ]; then
    cp .p10k.zsh ~/.p10k.zsh
fi
```

### 步骤7: 安装字体

#### 方法1: 使用包管理器
```bash
# Ubuntu/Debian
sudo apt install fonts-hack-ttf

# CentOS/RHEL
sudo yum install google-hack-fonts

# Fedora
sudo dnf install google-hack-fonts

# Arch Linux
sudo pacman -S ttf-hack-nerd
```

#### 方法2: 手动安装
```bash
# 创建字体目录
mkdir -p ~/.local/share/fonts

# 下载字体
cd ~/.local/share/fonts
wget -O "Hack Nerd Font Complete.ttf" "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf"

# 刷新字体缓存
fc-cache -fv
```

### 步骤8: 设置默认 Shell
```bash
# 查看可用 shell
cat /etc/shells

# 设置 ZSH 为默认 shell
chsh -s $(which zsh)

# 重新登录或运行
exec zsh
```

## 🧪 测试配置

### 1. 基础功能测试
```bash
# 启动 ZSH
zsh

# 在 ZSH 中测试：
# - 自动建议：输入命令时应该看到灰色建议
# - 语法高亮：命令应该有颜色
# - 主题显示：应该看到 Powerlevel10k 主题
```

### 2. 插件功能测试
```bash
# 测试自动建议
echo "测试自动建议功能"

# 测试语法高亮
ls -la

# 测试自动跳转
j <目录名>
```

### 3. 字体测试
```bash
# 测试图标显示
echo "测试图标: 🚀 📁 📄 ⚡"
```

## 🔧 故障排除

### 问题1: 字体显示异常
```bash
# 检查字体是否正确安装
fc-list | grep -i hack

# 重新安装字体
sudo apt install fonts-hack-ttf  # Ubuntu/Debian
```

### 问题2: 插件不工作
```bash
# 检查插件目录
ls -la ~/.oh-my-zsh/custom/plugins/

# 重新安装插件
cd ~/.oh-my-zsh/custom/plugins/
rm -rf zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions
```

### 问题3: 主题不显示
```bash
# 检查主题是否正确安装
ls -la ~/.oh-my-zsh/custom/themes/powerlevel10k/

# 重新安装主题
cd ~/.oh-my-zsh/custom/themes/
rm -rf powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
```

### 问题4: 权限问题
```bash
# 修复权限
chmod 755 ~/.oh-my-zsh
chmod 644 ~/.zshrc
chmod 644 ~/.p10k.zsh
```

## 📚 常用命令

### 重新加载配置
```bash
source ~/.zshrc
```

### 重新配置 Powerlevel10k
```bash
p10k configure
```

### 查看插件状态
```bash
omz plugin list
```

### 更新 Oh My Zsh
```bash
omz update
```

## 🎯 最终验证清单

- [ ] ZSH 版本 >= 5.1
- [ ] Oh My Zsh 已安装
- [ ] Powerlevel10k 主题已安装
- [ ] 所有插件已安装
- [ ] 配置文件已复制
- [ ] 字体已安装
- [ ] 默认 shell 已设置为 ZSH
- [ ] 自动建议功能正常
- [ ] 语法高亮正常
- [ ] 主题显示正常
- [ ] 图标显示正常

## 📞 获取帮助

如果遇到问题，可以：

1. 查看 Oh My Zsh 文档：https://ohmyz.sh/
2. 查看 Powerlevel10k 文档：https://github.com/romkatv/powerlevel10k
3. 检查各插件的 GitHub 页面
4. 查看系统日志：`journalctl -xe` 