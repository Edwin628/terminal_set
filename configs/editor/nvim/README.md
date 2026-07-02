# 🚀 Neovim 配置指南

这是一个现代化的 Neovim 配置，专为开发人员设计，提供了类似 VS Code 的开发体验。

## 📁 目录结构

```
~/.config/nvim/
├── init.lua              # 主配置文件
├── lua/
│   ├── settings.lua      # 基础编辑器设置
│   ├── keymaps.lua       # 快捷键映射
│   ├── plugins.lua       # 插件管理
│   ├── lsp.lua           # LSP 配置
│   └── autocmds.lua      # 自动命令
└── README.md             # 说明文档
```

## ✨ 特性

- 🎨 **美观界面**: Catppuccin 主题 + 状态栏 + 文件图标
- 🔍 **强大搜索**: Telescope 模糊搜索
- 📁 **文件管理**: NvimTree 文件浏览器
- 🧠 **智能补全**: nvim-cmp + LSP
- 🔧 **语言支持**: 多语言 LSP 服务器
- 🐛 **调试支持**: nvim-dap 调试器
- ⚡ **高性能**: 优化的启动速度和响应性

## 🎯 主要快捷键

### 基础操作
| 快捷键 | 功能 |
|--------|------|
| `<Space>w` | 保存文件 |
| `<Space>q` | 退出 |
| `<Space>Q` | 强制退出 |
| `<Space>e` | 切换文件浏览器 |

### 窗口管理
| 快捷键 | 功能 |
|--------|------|
| `<Space>sv` | 垂直分割窗口 |
| `<Space>sh` | 水平分割窗口 |
| `<Space>sc` | 关闭窗口 |
| `<Space>so` | 只保留当前窗口 |

### 缓冲区管理
| 快捷键 | 功能 |
|--------|------|
| `<Space>bn` | 下一个缓冲区 |
| `<Space>bp` | 上一个缓冲区 |
| `<Space>bd` | 删除缓冲区 |

### 标签页管理
| 快捷键 | 功能 |
|--------|------|
| `<Space>tn` | 新建标签页 |
| `<Space>tc` | 关闭标签页 |
| `<Space>tl` | 下一个标签页 |
| `<Space>th` | 上一个标签页 |

### 搜索
| 快捷键 | 功能 |
|--------|------|
| `<Space>ff` | 模糊搜索文件 |
| `<Space>fg` | 模糊搜索文本 |
| `<Space>fb` | 搜索缓冲区 |
| `<Space>fh` | 搜索帮助 |
| `<Space>fr` | 搜索最近文件 |

### LSP 功能
| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转到定义 |
| `gr` | 查找引用 |
| `K` | 悬停文档 |
| `<Space>ca` | 代码操作 |
| `<Space>rn` | 重命名 |
| `<Space>f` | 格式化 |

### 编辑增强
| 快捷键 | 功能 |
|--------|------|
| `<Space>y` | 复制到系统剪贴板 |
| `<Space>p` | 从系统剪贴板粘贴 |
| `<Space>Y` | 复制整个文件 |
| `J` | 合并行 |
| `U` | 重做 |

## 🔌 插件列表

### 主题和界面
- **catppuccin/nvim**: 美观的主题
- **nvim-lualine/lualine.nvim**: 状态栏
- **nvim-tree/nvim-web-devicons**: 文件图标

### 文件管理
- **nvim-tree/nvim-tree.lua**: 文件浏览器

### 搜索
- **nvim-telescope/telescope.nvim**: 模糊搜索
- **nvim-telescope/telescope-fzf-native.nvim**: FZF 扩展

### 语法高亮
- **nvim-treesitter/nvim-treesitter**: 语法高亮和代码分析

### LSP 和补全
- **neovim/nvim-lspconfig**: LSP 配置
- **williamboman/mason.nvim**: LSP 服务器管理
- **hrsh7th/nvim-cmp**: 自动补全
- **L3MON4D3/LuaSnip**: 代码片段

### Git 集成
- **lewis6991/gitsigns.nvim**: Git 行高亮

### 编辑增强
- **windwp/nvim-autopairs**: 自动括号配对
- **numToStr/Comment.nvim**: 注释功能
- **lukas-reineke/indent-blankline.nvim**: 缩进线

### 调试
- **mfussenegger/nvim-dap**: 调试器
- **rcarriga/nvim-dap-ui**: 调试界面

### 其他工具
- **folke/which-key.nvim**: 快捷键提示
- **folke/todo-comments.nvim**: TODO 注释高亮
- **folke/trouble.nvim**: 问题列表

## 🛠️ 安装和配置

### 1. 安装 Neovim
```bash
# macOS
brew install neovim

# Ubuntu/Debian
sudo apt install neovim

# Arch Linux
sudo pacman -S neovim
```

### 2. 安装字体（推荐）
```bash
# 安装 Nerd Fonts
# 下载并安装 https://www.nerdfonts.com/font-downloads
```

### 3. 复制配置
```bash
# 备份现有配置（如果有）
mv ~/.config/nvim ~/.config/nvim.backup

# 复制新配置
cp -r /path/to/this/config ~/.config/nvim
```

### 4. 启动 Neovim
```bash
nvim
```

首次启动时，插件管理器会自动安装所有插件。

## 🔧 自定义配置

### 修改主题
编辑 `lua/plugins.lua` 中的主题配置：
```lua
{
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "catppuccin"
  end,
}
```

### 添加新插件
在 `lua/plugins.lua` 的 `require("lazy").setup({})` 中添加：
```lua
{
  "plugin-author/plugin-name",
  config = function()
    require("plugin-name").setup()
  end,
}
```

### 修改快捷键
编辑 `lua/keymaps.lua` 文件。

## 🌟 使用技巧

### 1. 快速打开文件
- `<Space>ff`: 模糊搜索文件
- `<Space>e`: 打开文件浏览器

### 2. 高效编辑
- `gd`: 跳转到定义
- `gr`: 查找所有引用
- `<Space>ca`: 查看可用的代码操作

### 3. 多窗口操作
- `<Space>sv`: 垂直分割
- `<Space>sh`: 水平分割
- `Ctrl+w` + `hjkl`: 在窗口间切换

### 4. 搜索和替换
- `<Space>fg`: 全局搜索文本
- `:%s/old/new/g`: 全局替换
- `:s/old/new/g`: 当前行替换

## 🐛 故障排除

### 插件安装失败
```bash
# 清理插件缓存
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.cache/nvim

# 重新启动 Neovim
nvim
```

### LSP 不工作
1. 确保安装了相应的语言工具
2. 检查 Mason 是否安装了 LSP 服务器
3. 运行 `:Mason` 查看安装状态

### 性能问题
1. 检查是否有大文件
2. 禁用不必要的插件
3. 调整 `updatetime` 设置

## 📚 学习资源

- [Neovim 官方文档](https://neovim.io/doc/)
- [Lazy.nvim 文档](https://github.com/folke/lazy.nvim)
- [LSP 配置指南](https://github.com/neovim/nvim-lspconfig)
- [Telescope 使用指南](https://github.com/nvim-telescope/telescope.nvim)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个配置！

## �� 许可证

MIT License 