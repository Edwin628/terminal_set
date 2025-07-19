# 🚀 Terminal Tools Configuration

一个跨平台的终端工具配置集合，支持 macOS、Linux 和 Windows。

## 📋 功能特性

- **跨平台支持**: 自动检测操作系统并适配配置
- **一键安装**: 提供通用安装脚本
- **模块化设计**: 按功能分类的配置文件
- **完整文档**: 详细的使用和部署指南

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
- **Neovim**: 现代化的 Vim 替代品

## 🚀 快速开始

### 方法一：一键安装（推荐）

```bash
# 克隆项目
git clone <your-repo-url>
cd terminal_set

# 运行通用安装脚本
./scripts/install/install_universal.sh
```

### 方法二：手动安装

1. **安装 Oh My Zsh**
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
   ```

2. **安装配置文件**
   ```bash
   cp configs/shell/.zshrc_universal ~/.zshrc
   cp configs/terminal/.tmux.conf ~/.tmux.conf
   cp configs/editor/.vimrc ~/.vimrc
   ```

3. **重启终端**
   ```bash
   source ~/.zshrc
   ```

## 📁 项目结构

```
terminal_set/
├── configs/                 # 配置文件
│   ├── shell/              # Shell 配置
│   ├── terminal/           # 终端工具配置
│   └── editor/             # 编辑器配置
├── docs/                   # 文档
│   ├── shell/              # Shell 相关文档
│   ├── terminal/           # 终端工具文档
│   ├── editor/             # 编辑器文档
│   ├── migration/          # 迁移指南
│   └── DEPLOYMENT_GUIDE.md # 部署指南
├── scripts/                # 脚本文件
│   ├── install/            # 安装脚本
│   └── check/              # 检查脚本
└── README.md               # 项目说明
```

## 🌍 跨平台支持

### 支持的操作系统
- **macOS** (Intel & Apple Silicon)
- **Linux** (Ubuntu, CentOS, Fedora, Arch Linux, openSUSE)
- **Windows** (通过 WSL 或 Git Bash)

### 自动检测功能
- 操作系统类型
- 包管理器类型
- 工具安装路径
- 架构类型

## 📖 详细文档

- **[部署指南](docs/DEPLOYMENT_GUIDE.md)**: 跨平台部署详细说明
- **[项目结构](docs/PROJECT_STRUCTURE.md)**: 项目目录结构说明
- **[Shell 配置](docs/shell/ZSH_README.md)**: Zsh 配置和使用指南
- **[Tmux 使用](docs/terminal/TMUX_README.md)**: Tmux 详细使用说明
- **[Vim 配置](docs/editor/VIM_README.md)**: Vim 配置和插件指南

## 🔧 配置说明

### 通用配置特点
- **自动路径检测**: 根据系统自动设置工具路径
- **错误处理**: 优雅处理缺失的工具和插件
- **向后兼容**: 支持不同版本的工具
- **性能优化**: 快速启动和响应

### 平台特定优化
- **macOS**: Homebrew 集成，Apple Silicon 支持
- **Linux**: 多发行版支持，包管理器自动检测
- **Windows**: WSL 和 Git Bash 支持

## 🐛 故障排除

### 常见问题

1. **Powerlevel10k 警告**
   ```bash
   # 配置 Powerlevel10k
   p10k configure
   
   # 或禁用 instant prompt
   echo 'typeset -g POWERLEVEL9K_INSTANT_PROMPT=off' >> ~/.zshrc
   ```

2. **插件加载失败**
   ```bash
   # 检查插件目录
   ls -la ~/.oh-my-zsh/custom/plugins/
   
   # 重新安装插件
   ./scripts/install/install_universal.sh
   ```

3. **权限问题**
   ```bash
   # 修复权限
   chmod -R g-w ~/.oh-my-zsh
   chmod +x scripts/install/install_universal.sh
   ```

## 🔄 更新和维护

### 更新配置
```bash
# 更新所有工具
./scripts/install/install_universal.sh

# 更新 Oh My Zsh
omz update

# 更新插件
cd ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git pull
cd ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
```

### 检查安装状态
```bash
# 运行检查脚本
./scripts/check/check_installation.sh
```

## 🤝 贡献指南

1. Fork 项目
2. 创建功能分支
3. 提交更改
4. 推送到分支
5. 创建 Pull Request

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 📞 支持

如果你遇到问题或有建议：

1. 查看 [故障排除](#故障排除) 部分
2. 阅读相关文档
3. 提交 Issue
4. 联系维护者

---

**注意**: 本配置适用于大多数 Unix-like 系统。如果在特定环境中遇到问题，请参考相应的平台文档。
