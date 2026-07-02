-- Neovim 基础设置
-- 包含界面、编辑、搜索等基础配置

local opt = vim.opt
local g = vim.g

-- ================================
-- 界面设置
-- ================================
opt.number = true                    -- 显示行号
opt.relativenumber = true            -- 显示相对行号
opt.cursorline = true                -- 高亮当前行
opt.cursorcolumn = true              -- 高亮当前列
opt.signcolumn = "yes"               -- 显示符号列
opt.colorcolumn = "80"               -- 显示第80列参考线
opt.scrolloff = 8                    -- 滚动时保持8行距离
opt.sidescrolloff = 8                -- 水平滚动时保持8列距离

-- ================================
-- 编辑设置
-- ================================
opt.tabstop = 2                      -- Tab 宽度
opt.shiftwidth = 2                   -- 缩进宽度
opt.expandtab = true                 -- 使用空格代替 Tab
opt.autoindent = true                -- 自动缩进
opt.smartindent = true               -- 智能缩进
opt.wrap = false                     -- 不自动换行
opt.linebreak = true                 -- 在单词边界换行
opt.breakindent = true               -- 保持缩进

-- ================================
-- 搜索设置
-- ================================
opt.ignorecase = true                -- 忽略大小写
opt.smartcase = true                 -- 智能大小写匹配
opt.hlsearch = true                  -- 高亮搜索结果
opt.incsearch = true                 -- 增量搜索

-- ================================
-- 文件设置
-- ================================
opt.encoding = "utf-8"               -- 文件编码
opt.fileencoding = "utf-8"           -- 文件编码
opt.backup = false                   -- 不创建备份文件
opt.writebackup = false              -- 不创建写入备份
opt.swapfile = false                 -- 不创建交换文件
opt.undofile = true                  -- 启用撤销文件
opt.undodir = vim.fn.expand("~/.cache/nvim/undo") -- 撤销文件目录

-- ================================
-- 性能设置
-- ================================
opt.lazyredraw = true                -- 延迟重绘
opt.updatetime = 300                 -- 更新时间间隔
opt.timeoutlen = 300                 -- 超时时间

-- ================================
-- 终端设置
-- ================================
opt.termguicolors = true             -- 启用真彩色
opt.mouse = "a"                      -- 启用鼠标
opt.clipboard = "unnamedplus"        -- 使用系统剪贴板

-- ================================
-- 其他设置
-- ================================
opt.hidden = true                    -- 允许隐藏缓冲区
opt.showmode = false                 -- 不显示模式
opt.showcmd = true                   -- 显示命令
opt.cmdheight = 1                    -- 命令行高度
opt.laststatus = 3                   -- 状态栏显示
opt.splitbelow = true                -- 水平分割在下方
opt.splitright = true                -- 垂直分割在右侧
opt.completeopt = "menu,menuone,noselect" -- 补全选项

-- ================================
-- 全局变量设置
-- ================================
g.loaded_netrw = 1                   -- 禁用 netrw
g.loaded_netrwPlugin = 1             -- 禁用 netrw 插件
g.loaded_matchparen = 1              -- 禁用括号匹配高亮
g.loaded_2html_plugin = 1            -- 禁用 2html 插件
g.loaded_logiPat = 1                 -- 禁用 logiPat 插件
g.loaded_rrhelper = 1                -- 禁用 rrhelper 插件
g.loaded_tarPlugin = 1               -- 禁用 tar 插件
g.loaded_tutor_mode_plugin = 1       -- 禁用 tutor 插件
g.loaded_vimball = 1                 -- 禁用 vimball 插件
g.loaded_vimballPlugin = 1           -- 禁用 vimball 插件
g.loaded_zip = 1                     -- 禁用 zip 插件
g.loaded_zipPlugin = 1               -- 禁用 zip 插件

-- 创建必要的目录
vim.fn.mkdir(vim.fn.expand("~/.cache/nvim/undo"), "p")
vim.fn.mkdir(vim.fn.expand("~/.cache/nvim/backup"), "p")
vim.fn.mkdir(vim.fn.expand("~/.cache/nvim/swap"), "p") 