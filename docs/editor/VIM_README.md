# Vim 配置说明

## 📋 目录
- [简介](#简介)
- [安装与配置](#安装与配置)
- [插件列表](#插件列表)
- [快捷键说明](#快捷键说明)
- [功能特性](#功能特性)
- [故障排除](#故障排除)

## 🎯 简介

这是一个基于 vim-plug 插件管理器的 Vim 配置，提供了现代化的编辑体验，包括：
- 语法高亮和自动补全
- 文件树和模糊搜索
- 状态栏美化
- 多语言支持
- LSP 集成

## 🔧 安装与配置

### 安装 vim-plug
```bash
# 自动安装（推荐）
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# 手动安装（如果网络有问题）
mkdir -p ~/.vim/autoload
# 然后手动创建 plug.vim 文件
```

### 配置文件位置
- **主配置文件**：`~/.vimrc`
- **插件目录**：`~/.vim/plugged/`

### 安装插件
```bash
# 启动 Vim
vim

# 在 Vim 中安装插件
:PlugInstall

# 或者从命令行安装
vim +PlugInstall +qall
```

## 🔌 插件列表

### 核心插件
| 插件 | 功能 | 状态 |
|------|------|------|
| **vim-surround** | 快速包裹符号 | ✅ 已配置 |
| **nerdtree** | 文件树 | ✅ 已配置 |
| **auto-pairs** | 自动括号 | ✅ 已配置 |
| **lightline.vim** | 状态栏 | ✅ 已配置 |
| **fzf** | 模糊搜索 | ✅ 已配置 |
| **vim-polyglot** | 多语言语法 | ✅ 已配置 |
| **coc.nvim** | LSP 补全 | ✅ 已配置 |

### 插件详细说明

#### 1. vim-surround
**功能**：快速添加、删除、修改包围符号
```vim
" 示例操作
ysiw"    " 用双引号包围单词
ds"      " 删除双引号
cs"'     " 将双引号改为单引号
```

#### 2. nerdtree
**功能**：文件树浏览器
```vim
" 快捷键
Ctrl + n    " 切换文件树
```

#### 3. auto-pairs
**功能**：自动插入配对符号
- 输入 `(` 自动插入 `)`
- 输入 `{` 自动插入 `}`
- 输入 `[` 自动插入 `]`

#### 4. lightline.vim
**功能**：美化状态栏
- 显示文件类型
- 显示 Git 状态
- 显示编码信息

#### 5. fzf
**功能**：模糊搜索
```vim
" 快捷键
Ctrl + p    " 文件搜索
Ctrl + g    " Git 文件搜索
```

#### 6. vim-polyglot
**功能**：多语言语法支持
- 支持 100+ 种编程语言
- 自动语法高亮
- 缩进规则

#### 7. coc.nvim
**功能**：LSP 补全引擎
```vim
" 快捷键
Tab         " 补全选择
Ctrl + n    " 下一个补全项
Ctrl + p    " 上一个补全项
```

## ⌨️ 快捷键说明

### 基础快捷键
```vim
" 文件操作
:w          " 保存文件
:q          " 退出
:wq         " 保存并退出
:q!         " 强制退出

" 移动
h j k l     " 左 下 上 右
w           " 下一个单词
b           " 上一个单词
0           " 行首
$           " 行尾
gg          " 文件开头
G           " 文件结尾
```

### 插件快捷键
```vim
" NerdTree
Ctrl + n    " 切换文件树

" fzf
Ctrl + p    " 文件搜索
Ctrl + g    " Git 文件搜索

" 清除搜索高亮
Space       " 清除搜索高亮

" 保存
Ctrl + s    " 保存文件
```

### 分屏操作
```vim
" 分屏
:sp         " 水平分屏
:vsp        " 垂直分屏

" 分屏移动
Ctrl + h    " 左分屏
Ctrl + j    " 下分屏
Ctrl + k    " 上分屏
Ctrl + l    " 右分屏
```

## 🎨 功能特性

### 基础设置
- **语法高亮**：自动启用
- **行号显示**：相对行号
- **光标高亮**：当前行高亮
- **搜索高亮**：实时搜索
- **鼠标支持**：启用鼠标操作

### 缩进设置
- **Tab 宽度**：4 个空格
- **自动缩进**：智能缩进
- **展开 Tab**：Tab 转为空格

### 搜索设置
- **忽略大小写**：默认忽略
- **智能大小写**：有大写时敏感
- **增量搜索**：实时搜索
- **高亮搜索**：高亮匹配项

### 界面美化
- **深色主题**：desert 主题
- **状态栏**：lightline 美化
- **文件树**：nerdtree 侧边栏

## 🔧 自定义配置

### 修改主题
```vim
" 在 .vimrc 中修改
colorscheme desert    " 改为其他主题
```

### 添加新插件
```vim
" 在 .vimrc 的插件区域添加
Plug '插件名/仓库名'
```

### 自定义快捷键
```vim
" 在 .vimrc 中添加
nnoremap <快捷键> <命令>
```

## 🚨 故障排除

### 常见问题

#### 1. 插件不加载
```bash
# 检查 vim-plug 是否正确安装
ls ~/.vim/autoload/plug.vim

# 重新安装插件
vim +PlugInstall +qall
```

#### 2. 语法高亮不工作
```vim
" 在 Vim 中执行
:syntax on
:filetype on
```

#### 3. 自动补全不工作
```bash
# 检查 coc.nvim 是否正确安装
ls ~/.vim/plugged/coc.nvim

# 重新安装
vim +PlugInstall +qall
```

#### 4. 文件树不显示
```vim
" 在 Vim 中执行
:NERDTreeToggle
```

### 重置配置
```bash
# 备份当前配置
cp ~/.vimrc ~/.vimrc.backup

# 删除插件目录
rm -rf ~/.vim/plugged

# 重新安装
vim +PlugInstall +qall
```

## 📦 插件管理

### 安装插件
```vim
" 在 Vim 中执行
:PlugInstall
```

### 更新插件
```vim
" 在 Vim 中执行
:PlugUpdate
```

### 删除插件
```vim
" 在 .vimrc 中注释掉插件行
" Plug '插件名/仓库名'

" 在 Vim 中执行
:PlugClean
```

### 查看插件状态
```vim
" 在 Vim 中执行
:PlugStatus
```

## 🎯 使用建议

### 新手入门
1. 先熟悉基础快捷键（h, j, k, l, w, b, 0, $）
2. 学习文件操作（:w, :q, :wq）
3. 使用文件树浏览文件（Ctrl + n）
4. 尝试模糊搜索（Ctrl + p）

### 进阶使用
1. 学习 vim-surround 操作
2. 使用 fzf 进行文件搜索
3. 配置 coc.nvim 进行代码补全
4. 自定义快捷键和配置

### 工作流程
1. 使用 `vim 文件名` 打开文件
2. 使用 `Ctrl + n` 打开文件树
3. 使用 `Ctrl + p` 搜索文件
4. 使用 `Tab` 进行代码补全
5. 使用 `:w` 保存文件

## 🔗 相关资源

### 官方文档
- [Vim 官方文档](https://vimhelp.org/)
- [vim-plug 文档](https://github.com/junegunn/vim-plug)
- [coc.nvim 文档](https://github.com/neoclide/coc.nvim)

### 学习资源
- [Vim 教程](https://vim.rtorr.com/)
- [Vim 快捷键速查](https://vim.rtorr.com/)
- [Vim 插件推荐](https://github.com/akrawchyk/awesome-vim)

---

**提示**：这个配置提供了现代化的 Vim 体验，适合从其他编辑器迁移的用户。 