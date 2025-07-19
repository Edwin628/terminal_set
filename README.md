# 终端工具配置集合

## 📋 目录
- [简介](#简介)
- [工具列表](#工具列表)
- [快速开始](#快速开始)
- [详细文档](#详细文档)
- [迁移指南](#迁移指南)
- [常见问题](#常见问题)

## 🎯 简介

这是一个完整的终端工具配置集合，包含：
- **Zsh 配置**：增强的 shell 体验
- **Neovim 配置**：现代化的编辑器
- **Tmux 配置**：终端复用器
- **Vim 配置**：传统编辑器
- **Bash 配置**：备用 shell 配置

所有配置都经过优化，提供一致且高效的开发体验。

## 🛠️ 工具列表

### 🔧 Shell 配置
| 工具 | 配置文件 | 状态 | 说明 |
|------|----------|------|------|
| **Zsh** | `~/.zshrc` | ✅ 已配置 | 主要 shell，集成 Oh My Zsh + Powerlevel10k |
| **Bash** | `~/.bashrc` | ✅ 已配置 | 备用 shell，基础增强功能 |
| **Zsh 迁移包** | `zsh_migration_backup/` | ✅ 已准备 | Linux 迁移专用配置 |

### 📝 编辑器配置
| 工具 | 配置文件 | 状态 | 说明 |
|------|----------|------|------|
| **Neovim** | `~/.config/nvim/` | ✅ 已配置 | 现代化编辑器，LSP + 插件 |
| **Vim** | `~/.vimrc` | ✅ 已配置 | 传统编辑器，vim-plug 插件 |

### 🖥️ 终端工具
| 工具 | 配置文件 | 状态 | 说明 |
|------|----------|------|------|
| **Tmux** | `~/.tmux.conf` | ✅ 已配置 | 终端复用器，TPM 插件 |

## 🚀 快速开始

### 1. 检查当前状态
```bash
# 检查所有工具是否已安装
which zsh bash nvim vim tmux

# 检查配置文件是否存在
ls -la ~/.zshrc ~/.bashrc ~/.vimrc ~/.tmux.conf
ls -la ~/.config/nvim/
```

### 2. 启动工具
```bash
# 启动 Zsh（默认 shell）
zsh

# 启动 Neovim
nvim

# 启动 Vim
vim

# 启动 Tmux
tmux

# 启动 Bash
bash
```

### 3. 重新加载配置
```bash
# 重新加载 Zsh 配置
source ~/.zshrc

# 重新加载 Bash 配置
source ~/.bashrc

# 重新加载 Tmux 配置
tmux source-file ~/.tmux.conf
```

## 📚 详细文档

### Shell 配置
- **[Zsh 配置说明](docs/shell/ZSH_README.md)** - Oh My Zsh + Powerlevel10k 详细指南
- **[Bash 配置说明](docs/migration/zsh_migration_backup/BASH_README.md)** - Bash 增强功能说明

### 编辑器配置
- **[Neovim 配置说明](configs/editor/nvim/README.md)** - 完整 Neovim 配置指南
- **[Vim 配置说明](docs/editor/VIM_README.md)** - Vim 插件和设置说明

### 终端工具
- **[Tmux 使用指南](docs/terminal/TMUX_README.md)** - 完整的 Tmux 使用说明
- **[Tmux 快速参考](docs/terminal/TMUX_QUICK_REFERENCE.md)** - 常用命令速查

### 迁移和安装
- **[Zsh 迁移指南](docs/migration/zsh_migration_backup/README.md)** - Linux 迁移说明
- **[项目结构说明](docs/PROJECT_STRUCTURE.md)** - 文件组织说明
- **[工具检查清单](scripts/check/TOOLS_CHECKLIST.md)** - 安装检查指南

## 🔄 迁移指南

### 从 macOS 迁移到 Linux

#### 1. 使用自动安装脚本
```bash
# 下载迁移包
# 运行安装脚本
cd zsh_migration_backup
./install_on_linux.sh
```

#### 2. 手动安装
```bash
# 安装 Zsh
sudo apt install zsh

# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 复制配置文件
cp .zshrc_terminal_only ~/.zshrc
cp .p10k.zsh ~/.p10k.zsh

# 安装插件
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

### 从 Linux 迁移到 macOS

#### 1. 使用 Homebrew 安装
```bash
# 安装工具
brew install zsh nvim tmux

# 复制配置文件
cp ~/.zshrc ~/.zshrc.backup
cp .zshrc ~/.zshrc
```

## 🎨 主题和外观

### Powerlevel10k 主题
- **自动配置**：运行 `p10k configure` 重新配置
- **颜色方案**：支持浅色/深色主题
- **图标支持**：需要安装 Nerd Fonts

### Neovim 主题
- **默认主题**：tokyonight
- **状态栏**：lualine
- **文件树**：nvim-tree

### Tmux 状态栏
- **位置**：底部
- **颜色**：黑色背景，白色文字
- **信息**：会话名、窗口号、时间

## 🔧 自定义配置

### 修改 Zsh 配置
```bash
# 编辑配置文件
vim ~/.zshrc

# 重新加载
source ~/.zshrc
```

### 修改 Neovim 配置
```bash
# 编辑配置文件
nvim ~/.config/nvim/init.lua

# 重新加载（在 Neovim 中）
:source %
```

### 修改 Tmux 配置
```bash
# 编辑配置文件
vim ~/.tmux.conf

# 重新加载
tmux source-file ~/.tmux.conf
```

## 🚨 故障排除

### 常见问题

#### 1. Zsh 插件不工作
```bash
# 检查插件是否正确安装
ls ~/.oh-my-zsh/custom/plugins/

# 重新安装插件
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
```

#### 2. Neovim 插件不加载
```bash
# 检查插件管理器
nvim --headless -c "Lazy! sync" -c "qa"

# 手动安装插件
nvim --headless -c "Lazy install" -c "qa"
```

#### 3. Tmux 插件不工作
```bash
# 安装 TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 在 tmux 中安装插件
Ctrl + a, I
```

### 重置配置
```bash
# 备份当前配置
cp ~/.zshrc ~/.zshrc.backup
cp ~/.vimrc ~/.vimrc.backup
cp ~/.tmux.conf ~/.tmux.conf.backup

# 恢复默认配置
# 从本仓库重新复制配置文件
```

## 📦 安装脚本

### 一键安装脚本
```bash
# 运行一键安装脚本（推荐）
./scripts/install/install_all.sh
```

### 安装检查脚本
```bash
# 检查安装状态
./scripts/check/check_installation.sh
```

### Linux 迁移脚本
```bash
# 运行 Linux 迁移脚本
cd docs/migration/zsh_migration_backup
./install_on_linux.sh
```

### Bash 配置安装脚本
```bash
# 运行 Bash 配置安装脚本
cd docs/migration/zsh_migration_backup
./install_bash_config.sh
```

## 🔗 相关资源

### 官方文档
- [Zsh 官方文档](https://zsh.sourceforge.io/Doc/)
- [Oh My Zsh 文档](https://ohmyz.sh/)
- [Powerlevel10k 文档](https://github.com/romkatv/powerlevel10k)
- [Neovim 文档](https://neovim.io/doc/)
- [Tmux 文档](https://github.com/tmux/tmux/wiki)

### 插件资源
- [Zsh 插件列表](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
- [Neovim 插件](https://github.com/rockerBOO/awesome-neovim)
- [Tmux 插件](https://github.com/rothgar/awesome-tmux)

## 📝 更新日志

### v1.0.0 (2024-07-19)
- ✅ 完整的 Zsh 配置（Oh My Zsh + Powerlevel10k）
- ✅ 完整的 Neovim 配置（LSP + 插件）
- ✅ 完整的 Tmux 配置（TPM 插件）
- ✅ Vim 配置（vim-plug 插件）
- ✅ Bash 配置（基础增强）
- ✅ Linux 迁移包
- ✅ 详细文档和说明

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个配置集合！

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

---

**提示**：所有配置文件都经过测试和优化，可以直接使用。如有问题，请查看相应的详细文档。
