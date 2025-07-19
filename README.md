# 🚀 Terminal Tools Configuration

一个简单的终端工具配置集合，支持 macOS 和 Linux。

## 📋 功能特性

- **双平台支持**: 专门的 macOS 和 Linux 脚本
- **一键安装**: 简单的安装脚本
- **完整配置**: Zsh、Tmux、Vim 配置
- **颜色定制**: 提供颜色修改工具

## 🛠️ 包含的工具

### Shell 环境
- **Zsh** + **Oh My Zsh**: 强大的 shell 环境
- **Powerlevel10k**: 美观的终端主题
- **Zsh 插件**: 自动补全、语法高亮、命令建议

### 终端工具
- **Tmux**: 终端复用器
- **FZF**: 模糊查找工具
- **Ripgrep**: 快速文本搜索

### 编辑器
- **Vim**: 经典文本编辑器

## 🚀 快速开始

### macOS 用户

```bash
# 克隆项目
git clone <your-repo-url>
cd terminal_set

# 运行 macOS 安装脚本
./scripts/install/install_macos.sh
```

### Linux 用户

```bash
# 克隆项目
git clone <your-repo-url>
cd terminal_set

# 运行 Linux 安装脚本
./scripts/install/install_linux.sh
```

## 🎨 颜色定制

### 快速颜色修改
```bash
# 简单易用的颜色修改工具
./scripts/customize/quick_colors.sh
```

### 高级颜色配置
```bash
# 完整的颜色配置工具
./scripts/customize/change_colors.sh
```

### 手动修改
```bash
# 重新配置 Powerlevel10k
p10k configure

# 或直接编辑配置文件
vim ~/.p10k.zsh
```

## 📁 项目结构

```
terminal_set/
├── configs/                 # 配置文件
│   ├── shell/              # Shell 配置
│   │   ├── .zshrc_macos    # macOS 专用配置
│   │   └── .zshrc_linux    # Linux 专用配置
│   ├── terminal/           # 终端工具配置
│   └── editor/             # 编辑器配置
├── scripts/                # 脚本文件
│   ├── install/            # 安装脚本
│   │   ├── install_macos.sh # macOS 安装脚本
│   │   └── install_linux.sh # Linux 安装脚本
│   └── customize/          # 定制脚本
│       ├── quick_colors.sh  # 快速颜色修改
│       └── change_colors.sh # 完整颜色配置
└── README.md               # 项目说明
```

## 🖥️ 平台支持

### macOS
- 自动安装 Homebrew
- 安装常用开发工具
- 配置 Apple Silicon 和 Intel 支持

### Linux
- 支持多种包管理器 (apt, yum, dnf, pacman, zypper)
- 自动检测系统类型
- 设置 zsh 为默认 shell

## 🔧 安装内容

### 基础工具
- git, curl, wget, tree, htop
- fzf, ripgrep, bat, fd
- tmux, vim

### Shell 环境
- Oh My Zsh
- Powerlevel10k 主题
- zsh-autosuggestions
- zsh-syntax-highlighting
- zsh-completions

### 配置文件
- .zshrc (平台专用)
- .tmux.conf
- .vimrc

## 🐛 故障排除

### 常见问题

1. **Powerlevel10k 警告**
   ```bash
   # 配置 Powerlevel10k
   p10k configure
   ```

2. **权限问题**
   ```bash
   # 修复权限
   chmod -R g-w ~/.oh-my-zsh
   ```

3. **插件不工作**
   ```bash
   # 重新加载配置
   source ~/.zshrc
   ```

4. **颜色不满意**
   ```bash
   # 使用颜色修改工具
   ./scripts/customize/quick_colors.sh
   ```

## 🔄 更新

### 更新工具
```bash
# macOS
brew update && brew upgrade

# Linux (Ubuntu/Debian)
sudo apt update && sudo apt upgrade
```

### 更新 Oh My Zsh
```bash
omz update
```

### 更新插件
```bash
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-completions && git pull
```

## 📖 使用说明

### 重启终端
安装完成后，重启终端或运行：
```bash
source ~/.zshrc
```

### 配置 Powerlevel10k
```bash
p10k configure
```

### 使用 Tmux
```bash
tmux
```

### 自定义颜色
```bash
# 快速修改
./scripts/customize/quick_colors.sh

# 高级配置
./scripts/customize/change_colors.sh
```

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License

---

**注意**: 安装脚本会自动备份现有配置文件。
