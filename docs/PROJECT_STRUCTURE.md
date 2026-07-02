# 项目结构说明

## 📁 目录结构

```
terminal_set/
├── README.md                           # 主项目说明文档
│
├── configs/                            # 配置文件（唯一源）
│   ├── shell/                          # Shell 配置文件
│   │   ├── .zshrc                      # 跨平台 Zsh 配置（完整版）
│   │   ├── .zshrc_macos                # macOS 专用 Zsh 配置
│   │   ├── .zshrc_linux                # Linux 专用 Zsh 配置
│   │   ├── .zshrc_universal            # 通用 Zsh 配置
│   │   ├── .bashrc                     # Bash 基础配置
│   │   ├── .bashrc_enhanced            # Bash 增强配置
│   │   └── .p10k.zsh                   # Powerlevel10k 主题配置
│   │
│   ├── editor/                         # 编辑器配置文件
│   │   ├── .vimrc                      # Vim 配置文件
│   │   └── nvim/                       # Neovim 配置（模块化增强版）
│   │       ├── init.lua                # 入口文件（加载模块）
│   │       ├── README.md               # Neovim 配置说明
│   │       ├── lazy-lock.json          # 插件版本锁定
│   │       └── lua/                    # Lua 配置模块
│   │           ├── settings.lua        # 基础设置
│   │           ├── keymaps.lua         # 快捷键映射
│   │           ├── plugins.lua         # 插件管理
│   │           ├── lsp.lua             # LSP 配置
│   │           └── autocmds.lua        # 自动命令
│   │
│   └── terminal/                       # 终端工具配置文件
│       └── .tmux.conf                  # Tmux 配置文件
│
├── scripts/                            # 脚本目录
│   ├── install/                        # 安装脚本
│   │   ├── install_all.sh              # 一键安装
│   │   ├── install_bash_plugins.sh     # Bash 插件安装
│   │   ├── install_linux.sh            # Linux 安装
│   │   ├── install_macos.sh            # macOS 安装
│   │   └── install_universal.sh        # 通用安装
│   ├── customize/                      # 定制脚本
│   │   ├── apply_current_theme.sh      # 应用当前主题
│   │   ├── change_colors.sh            # 颜色配置
│   │   └── quick_colors.sh             # 快速颜色修改
│   ├── check/                          # 检查脚本
│   │   ├── check_installation.sh       # 安装检查
│   │   └── TOOLS_CHECKLIST.md          # 工具检查清单
│   └── test/                           # 测试脚本
│       ├── test_bash_features.sh       # Bash 功能测试
│       └── test_nvim.sh                # Neovim 配置测试
│
└── docs/                               # 文档目录
    ├── PROJECT_STRUCTURE.md            # 项目结构说明（本文件）
    ├── DEPLOYMENT_GUIDE.md             # 部署指南
    ├── shell/                          # Shell 文档
    │   ├── ZSH_README.md               # Zsh 配置说明
    │   └── BASH_PLUGINS_GUIDE.md       # Bash 插件指南
    ├── editor/                         # 编辑器文档
    │   └── VIM_README.md               # Vim 配置说明
    └── terminal/                       # 终端工具文档
        ├── TMUX_README.md              # Tmux 详细指南
        └── TMUX_QUICK_REFERENCE.md     # Tmux 快速参考
```

## 📋 文件说明

### 🎯 主要文档

| 文件 | 说明 | 用途 |
|------|------|------|
| `README.md` | 主项目说明 | 项目概览、快速开始、工具列表 |
| `docs/PROJECT_STRUCTURE.md` | 项目结构 | 文件组织说明（本文件） |
| `docs/DEPLOYMENT_GUIDE.md` | 部署指南 | 安装部署详细步骤 |

### 🔧 Shell 配置

| 文件 | 说明 | 用途 |
|------|------|------|
| `configs/shell/.zshrc` | 跨平台 Zsh 配置 | 完整版，含跨平台检测、PATH 管理、开发工具 |
| `configs/shell/.zshrc_macos` | macOS 专用 Zsh | Homebrew、NVM、Conda 等 macOS 环境 |
| `configs/shell/.zshrc_linux` | Linux 专用 Zsh | Snap、Flatpak、Go 等 Linux 环境 |
| `configs/shell/.zshrc_universal` | 通用 Zsh 配置 | 适用于所有平台的基础配置 |
| `configs/shell/.bashrc` | Bash 基础配置 | Bash 基础配置文件 |
| `configs/shell/.bashrc_enhanced` | Bash 增强配置 | 类似 Zsh 插件功能的 Bash 配置 |
| `configs/shell/.p10k.zsh` | Powerlevel10k 主题 | rainbow 风格主题配置 |
| `docs/shell/ZSH_README.md` | Zsh 配置说明 | Oh My Zsh + Powerlevel10k 详细指南 |
| `docs/shell/BASH_PLUGINS_GUIDE.md` | Bash 插件指南 | Bash 增强功能使用说明 |

### 📝 编辑器配置

| 文件 | 说明 | 用途 |
|------|------|------|
| `configs/editor/.vimrc` | Vim 配置 | vim-plug + NerdTree + FZF + CoC |
| `configs/editor/nvim/init.lua` | Neovim 入口 | 模块化加载各配置文件 |
| `configs/editor/nvim/lua/settings.lua` | 基础设置 | 界面、编辑、搜索、性能配置 |
| `configs/editor/nvim/lua/keymaps.lua` | 快捷键 | 窗口、缓冲区、LSP、调试等快捷键 |
| `configs/editor/nvim/lua/plugins.lua` | 插件管理 | Lazy.nvim 插件安装和配置 |
| `configs/editor/nvim/lua/lsp.lua` | LSP 配置 | Mason + 多语言服务器配置 |
| `configs/editor/nvim/lua/autocmds.lua` | 自动命令 | 文件类型、自动保存、性能优化 |
| `configs/editor/nvim/README.md` | Neovim 说明 | 完整功能文档、快捷键列表 |
| `docs/editor/VIM_README.md` | Vim 配置说明 | vim-plug 插件和设置指南 |

### 🖥️ 终端工具

| 文件 | 说明 | 用途 |
|------|------|------|
| `configs/terminal/.tmux.conf` | Tmux 配置 | Ctrl-a 前缀、分屏、TPM 插件 |
| `docs/terminal/TMUX_README.md` | Tmux 详细指南 | 完整使用说明和教程 |
| `docs/terminal/TMUX_QUICK_REFERENCE.md` | Tmux 快速参考 | 常用命令速查 |

### 🔧 脚本文件

| 文件 | 说明 | 用途 |
|------|------|------|
| `scripts/install/install_all.sh` | 一键安装 | 自动安装所有工具和配置 |
| `scripts/install/install_linux.sh` | Linux 安装 | Linux 平台专用安装脚本 |
| `scripts/install/install_macos.sh` | macOS 安装 | macOS 平台专用安装脚本 |
| `scripts/install/install_universal.sh` | 通用安装 | 跨平台安装脚本 |
| `scripts/install/install_bash_plugins.sh` | Bash 插件 | Bash 增强功能安装 |
| `scripts/customize/quick_colors.sh` | 快速颜色 | 简单易用的颜色修改工具 |
| `scripts/customize/change_colors.sh` | 颜色配置 | 完整的颜色配置工具 |
| `scripts/check/check_installation.sh` | 安装检查 | 检查安装状态和配置 |
| `scripts/test/test_bash_features.sh` | Bash 测试 | 测试 Bash 增强功能 |
| `scripts/test/test_nvim.sh` | Neovim 测试 | 测试 Neovim 配置是否正常 |

## 🎯 使用指南

### 新手入门
1. 阅读 `README.md` 了解项目概览
2. 运行 `scripts/check/check_installation.sh` 检查当前环境
3. 根据需要阅读具体工具的说明文档

### 快速安装

```bash
# Linux 用户
./scripts/install/install_linux.sh

# macOS 用户
./scripts/install/install_macos.sh

# 一键安装所有
./scripts/install/install_all.sh
```

### 工具使用
- **Zsh**: 查看 `docs/shell/ZSH_README.md`
- **Bash**: 查看 `docs/shell/BASH_PLUGINS_GUIDE.md`
- **Vim**: 查看 `docs/editor/VIM_README.md`
- **Neovim**: 查看 `configs/editor/nvim/README.md`
- **Tmux**: 查看 `docs/terminal/TMUX_README.md`

### 故障排除
1. 运行 `scripts/check/check_installation.sh` 进行诊断
2. 参考 `scripts/check/TOOLS_CHECKLIST.md` 进行故障排除
3. 参考各工具的说明文档

## 📊 文件统计

### 配置文件
- **Shell 配置**: 7 个（Zsh × 4 + Bash × 2 + p10k）
- **编辑器配置**: Vim 1 个 + Neovim 6 个（模块化）
- **终端工具**: 1 个（Tmux）

### 脚本文件
- **安装脚本**: 5 个
- **定制脚本**: 3 个
- **检查脚本**: 1 个
- **测试脚本**: 2 个

### 文档文件
- **总文档数**: 8 个 Markdown 文件
- **配置说明**: 4 个主要工具说明
- **快速参考**: 1 个速查文档

## 🔗 相关链接

### 官方文档
- [Zsh 官方文档](https://zsh.sourceforge.io/Doc/)
- [Oh My Zsh 文档](https://ohmyz.sh/)
- [Neovim 文档](https://neovim.io/doc/)
- [Tmux 文档](https://github.com/tmux/tmux/wiki)

### 插件资源
- [Zsh 插件列表](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
- [Neovim 插件](https://github.com/rockerBOO/awesome-neovim)
- [Tmux 插件](https://github.com/rothgar/awesome-tmux)

---

**提示**：所有配置文件都经过测试和优化，可以直接使用。如有问题，请查看相应的详细文档。 