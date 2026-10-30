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
- C/C++ 优先，兼顾 Python、Shell、JSON 和 Vimscript
- CoC + clangd 语义高亮、诊断、跳转与重构

本文对应 `configs/editor/.vimrc`。`configs/editor/nvim/` 是独立的 Lua/lazy.nvim + 原生 LSP 配置，不要同时加载两套补全框架。

## 🔧 安装与配置

### 依赖与兼容性
- 当前 CoC release 要求 **Vim ≥ 9.0.0438 或 Neovim ≥ 0.8.0**，以及 **Node.js ≥ 22.15.0**；版本要求以 [CoC 安装说明](https://cocnvim.com/docs/install-coc.nvim) 为准。
- Vim 8.2 仍可运行基础配置和其他插件，但配置会跳过 CoC 并提示升级。Ubuntu 22.04 的系统 Vim/Node.js 不一定满足当前 CoC 要求。
- 需要 Git；C/C++ 需要 `clangd`（可通过系统包管理器或 `:CocCommand clangd.install` 安装）。文本搜索 `:Rg` 需要 `ripgrep`；fzf 可由插件安装钩子安装。
- 缺少 vim-plug 时不自动联网或隐藏错误，保留基础编辑能力；缺少 CoC 时 Tab/Enter 正常回退。没有剪贴板支持的 Vim 不强制使用系统剪贴板。

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
| **coc-pairs**（CoC 扩展） | 唯一的自动配对引擎 | ✅ 已配置 |
| **lightline.vim** | 状态栏 | ✅ 已配置 |
| **fzf + fzf.vim** | 文件、Buffer、Git 文件和文本搜索 | ✅ 命令按需加载 |
| **vim-cpp-enhanced-highlight** | C/C++ 语法增强 | ✅ 按文件类型加载 |
| **coc.nvim**（release） | LSP 补全与语义高亮 | ✅ 需满足版本要求 |

NERDTree 按命令加载。Python、Shell 等使用 Vim 自带语法；不再加载覆盖上百种语言的 vim-polyglot。clangd 的语义高亮由 CoC 原生处理，无需旧的 vim-lsp-cxx-highlight；只保留一套搜索、文件树和配对方案，不引入 LeaderF、defx 或 Python RPC 桥接库。

默认 CoC 扩展：`coc-clangd`、`coc-pyright`、`coc-sh`、`coc-json`、`coc-git`、`coc-pairs`、`coc-vimlsp`。不默认启用 TabNine；已有自定义扩展会保留，重复加载配置不会重复追加。迁移时可用 `:CocUninstall coc-python` 移除旧 Python 扩展；同时删除自定义列表中对应的旧条目。

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

#### 3. coc-pairs
**功能**：由 CoC 统一处理自动配对，避免多个插件同时修改输入
- 输入 `(`、`{`、`[` 自动插入对应闭合符号
- C/C++ 缓冲区禁用 `<` 配对，比较运算和 `<<` 不再插入多余的 `>`
- 其他语言不设置该禁用项；CoC 不可用时仅保留普通输入

#### 4. lightline.vim
**功能**：美化状态栏
- 显示文件类型
- 显示当前模式和文件状态
- 显示编码信息

#### 5. fzf
**功能**：模糊搜索
```vim
" 快捷键
Ctrl + p    " 文件搜索
Ctrl + g    " Git 文件搜索
```

#### 6. vim-cpp-enhanced-highlight
**功能**：C/C++ 语法增强
- 按 `c`、`cpp` 文件类型加载
- 启用类作用域和成员变量高亮
- 禁用实验性模板正则高亮，语义类型交给 clangd + CoC

#### 7. coc.nvim
**功能**：LSP 补全引擎
```vim
" 快捷键
Tab         " 下一个候选；空白处缩进，无 CoC 时正常插入 Tab
Shift+Tab   " 上一个候选；无候选时减少缩进
Enter       " 确认候选；无候选时换行
Ctrl+Space  " 手动触发补全；无 CoC 时使用原生补全
```

### C/C++ 项目配置
clangd 默认启用后台索引和详细补全，禁用补全时自动插入头文件。不默认开启 clang-tidy，避免增加大型项目分析负担；可按项目启用。

为真实项目生成编译数据库，避免系统头文件、宏和编译选项识别错误：
```bash
cmake -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
```
在项目根目录的 `.clangd` 中指定数据库目录（已有文件则合并配置）：
```yaml
CompileFlags:
  CompilationDatabase: build
```
不要全局强制 C++ 标准或系统 include 路径，让编译数据库决定项目参数。

内置参数集中在 `.vimrc` 的 `g:coc_user_config` 中；预先设置的同名值会保留。该变量优先于用户级 `:CocConfig`，需要修改同名默认项时请编辑 `.vimrc`，或在加载前设置该变量。资源级参数也可在 `:CocLocalConfig`（项目 `.vim/coc-settings.json`）中覆盖。扩展安装和 clangd 运行状态可通过 `:CocList extensions`、`:CocInfo`、`:CocCommand workspace.showOutput` 检查。

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
<leader>fb  " Buffer 搜索
<leader>fg  " 项目文本搜索（需要 ripgrep）

" CoC 初始化成功后生效
gd          " 定义
gy          " 类型定义
gi          " 实现
gr          " 引用
K           " 悬浮文档；Vimscript 中仍查询 help
[g / ]g     " 上一个/下一个诊断
<leader>rn  " 重命名
<leader>ca  " 当前位置的代码操作
<leader>f   " 格式化文件；可视模式下格式化选区

" 清除搜索高亮
Space       " 清除搜索高亮

" 保存
Ctrl + s    " 保存文件
```

`<leader>` 沿用 Vim 默认的反斜杠 `\`，例如 `\rn` 重命名；可在加载配置前设置 `mapleader`。空格仍用于清除搜索高亮。

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
- **鼠标支持**：默认关闭鼠标，保留终端原生选择

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
先检查 `vim --version`、`node --version` 和 `clangd --version` 是否满足依赖，再在 Vim 内执行：
```vim
:CocInfo
:CocList extensions
:CocCommand workspace.showOutput
```
缺少插件时运行 `:PlugInstall`；缺少扩展时可运行 `:CocInstall coc-clangd coc-pyright coc-sh coc-json coc-git coc-pairs coc-vimlsp`。版本不满足时应先升级，而不是反复重装。不要同时配置另一套 clangd `languageserver` 或自动配对插件。

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

## 🧪 自动验证
在仓库中执行：
```bash
python3 scripts/test/test_vim.py
```
测试不联网、不安装插件、不修改用户 HOME；会隔离运行已安装的 Vim/Neovim，验证基础启动、缺插件回退、插件声明和按需加载、C/C++ 配对作用域、补全按键、重复加载以及自定义配置保留。失败时退出码非零。

CoC 和 vim-plug 分支使用测试桩，不能据此认定真实插件已安装或 LSP 已联通；此脚本也不测试独立的 Neovim Lua 配置。完整集成验证还需在满足版本要求且安装插件后，打开有编译数据库的 C/C++ 项目，检查补全、`gd`、`gr`、诊断及 `<`/`<<` 输入。

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