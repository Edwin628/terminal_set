# 项目结构说明

## 📁 目录结构

```
terminal_set/
├── README.md                           # 主项目说明文档
│
├── 📚 docs/                            # 文档目录
│   ├── PROJECT_STRUCTURE.md            # 项目结构说明（本文件）
│   │
│   ├── 🔧 shell/                       # Shell 配置文档
│   │   └── ZSH_README.md               # Zsh 配置详细说明
│   │
│   ├── 📝 editor/                      # 编辑器配置文档
│   │   └── VIM_README.md               # Vim 配置详细说明
│   │
│   ├── 🖥️ terminal/                    # 终端工具文档
│   │   ├── TMUX_README.md              # Tmux 详细使用指南
│   │   └── TMUX_QUICK_REFERENCE.md     # Tmux 快速参考
│   │
│   └── 🔄 migration/                   # 迁移相关文档
│       └── zsh_migration_backup/       # Linux 迁移专用包
│           ├── README.md               # 迁移说明
│           ├── BASH_README.md          # Bash 配置说明
│           ├── manual_install_guide.md # 手动安装指南
│           ├── .zshrc_terminal_only    # 精简版 Zsh 配置
│           ├── .p10k.zsh               # Powerlevel10k 配置
│           ├── .bashrc                 # Bash 配置文件
│           ├── install_on_linux.sh     # Linux 自动安装脚本
│           └── install_bash_config.sh  # Bash 配置安装脚本
│
├── ⚙️ configs/                          # 配置文件目录
│   ├── 🔧 shell/                       # Shell 配置文件
│   │   ├── .zshrc                      # Zsh 配置文件
│   │   └── .bashrc                     # Bash 配置文件
│   │
│   ├── 📝 editor/                      # 编辑器配置文件
│   │   ├── .vimrc                      # Vim 配置文件
│   │   └── nvim/                       # Neovim 配置目录
│   │       ├── init.lua                # Neovim 主配置文件
│   │       ├── README.md               # Neovim 配置说明
│   │       └── lua/                    # Lua 配置模块
│   │           ├── plugins.lua         # 插件配置
│   │           ├── settings.lua        # 编辑器设置
│   │           ├── keymaps.lua         # 快捷键映射
│   │           ├── lsp.lua             # LSP 配置
│   │           └── autocmds.lua        # 自动命令
│   │
│   └── 🖥️ terminal/                    # 终端工具配置文件
│       └── .tmux.conf                  # Tmux 配置文件
│
└── 🔧 scripts/                         # 脚本目录
    ├── 📦 install/                     # 安装脚本
    │   └── install_all.sh              # 一键安装脚本
    │
    └── 🔍 check/                       # 检查脚本
        ├── check_installation.sh       # 安装检查脚本
        └── TOOLS_CHECKLIST.md          # 工具检查清单
```

## 📋 文件说明

### 🎯 主要文档

| 文件 | 说明 | 用途 |
|------|------|------|
| `README.md` | 主项目说明 | 项目概览、快速开始、工具列表 |
| `docs/PROJECT_STRUCTURE.md` | 项目结构 | 文件组织说明（本文件） |

### 🔧 Shell 配置文档

| 文件 | 说明 | 用途 |
|------|------|------|
| `docs/shell/ZSH_README.md` | Zsh 配置说明 | Oh My Zsh + Powerlevel10k 详细指南 |
| `configs/shell/.zshrc` | Zsh 配置文件 | 项目中的配置文件副本 |
| `configs/shell/.bashrc` | Bash 配置文件 | 项目中的配置文件副本 |

### 📝 编辑器配置文档

| 文件 | 说明 | 用途 |
|------|------|------|
| `docs/editor/VIM_README.md` | Vim 配置说明 | vim-plug 插件和设置指南 |
| `configs/editor/.vimrc` | Vim 配置文件 | 项目中的配置文件副本 |
| `configs/editor/nvim/README.md` | Neovim 配置说明 | Lazy.nvim + LSP 详细指南 |
| `configs/editor/nvim/init.lua` | Neovim 主配置 | 配置加载入口 |
| `configs/editor/nvim/lua/plugins.lua` | 插件配置 | Lazy.nvim 插件管理 |
| `configs/editor/nvim/lua/settings.lua` | 编辑器设置 | 基础编辑器配置 |
| `configs/editor/nvim/lua/keymaps.lua` | 快捷键映射 | 自定义快捷键 |
| `configs/editor/nvim/lua/lsp.lua` | LSP 配置 | 语言服务器设置 |
| `configs/editor/nvim/lua/autocmds.lua` | 自动命令 | 自动执行命令 |

### 🖥️ 终端工具文档

| 文件 | 说明 | 用途 |
|------|------|------|
| `docs/terminal/TMUX_README.md` | Tmux 详细指南 | 完整使用说明和教程 |
| `docs/terminal/TMUX_QUICK_REFERENCE.md` | Tmux 快速参考 | 常用命令速查 |
| `configs/terminal/.tmux.conf` | Tmux 配置文件 | 项目中的配置文件副本 |

### 🔄 迁移包文档

| 文件 | 说明 | 用途 |
|------|------|------|
| `docs/migration/zsh_migration_backup/README.md` | 迁移说明 | Linux 迁移指南 |
| `docs/migration/zsh_migration_backup/BASH_README.md` | Bash 配置说明 | Bash 增强功能说明 |
| `docs/migration/zsh_migration_backup/manual_install_guide.md` | 手动安装指南 | 详细安装步骤 |
| `docs/migration/zsh_migration_backup/.zshrc_terminal_only` | 精简 Zsh 配置 | 仅终端体验的配置 |
| `docs/migration/zsh_migration_backup/.p10k.zsh` | Powerlevel10k 配置 | 主题配置文件 |
| `docs/migration/zsh_migration_backup/.bashrc` | Bash 配置文件 | 增强的 Bash 配置 |
| `docs/migration/zsh_migration_backup/install_on_linux.sh` | Linux 安装脚本 | 自动安装脚本 |
| `docs/migration/zsh_migration_backup/install_bash_config.sh` | Bash 安装脚本 | Bash 配置安装 |

### 🔧 脚本文件

| 文件 | 说明 | 用途 |
|------|------|------|
| `scripts/install/install_all.sh` | 一键安装脚本 | 自动安装所有工具和配置 |
| `scripts/check/check_installation.sh` | 安装检查脚本 | 检查安装状态和配置 |
| `scripts/check/TOOLS_CHECKLIST.md` | 工具检查清单 | 详细的安装检查指南 |

## 🎯 使用指南

### 新手入门
1. 阅读 `README.md` 了解项目概览
2. 运行 `scripts/check/check_installation.sh` 检查当前环境
3. 根据需要阅读具体工具的说明文档

### 快速安装
1. 运行 `scripts/install/install_all.sh` 一键安装
2. 或查看 `docs/migration/` 目录进行迁移

### 配置迁移
1. 查看 `docs/migration/zsh_migration_backup/README.md`
2. 使用 `docs/migration/zsh_migration_backup/install_on_linux.sh` 自动安装
3. 或参考 `docs/migration/zsh_migration_backup/manual_install_guide.md` 手动安装

### 工具使用
- **Zsh**: 查看 `docs/shell/ZSH_README.md`
- **Vim**: 查看 `docs/editor/VIM_README.md`
- **Neovim**: 查看 `configs/editor/nvim/README.md`
- **Tmux**: 查看 `docs/terminal/TMUX_README.md` 和 `docs/terminal/TMUX_QUICK_REFERENCE.md`

### 故障排除
1. 运行 `scripts/check/check_installation.sh` 进行诊断
2. 参考 `scripts/check/TOOLS_CHECKLIST.md` 进行故障排除
3. 参考各工具的说明文档
4. 检查配置文件是否正确复制

## 📊 文件统计

### 文档文件
- **总文档数**: 12 个 Markdown 文件
- **配置说明**: 4 个主要工具说明
- **快速参考**: 1 个速查文档
- **安装指南**: 2 个安装说明
- **迁移文档**: 3 个迁移相关文档

### 配置文件
- **Shell 配置**: 2 个（Zsh + Bash）
- **编辑器配置**: 2 个（Vim + Neovim）
- **终端工具**: 1 个（Tmux）
- **主题配置**: 1 个（Powerlevel10k）

### 脚本文件
- **安装脚本**: 2 个（Linux + Bash）
- **检查脚本**: 1 个（工具检查）

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