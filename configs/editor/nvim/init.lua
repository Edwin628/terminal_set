-- Neovim 主配置文件（模块化版本）
-- 描述: 现代化 Neovim 配置，适合开发使用

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 加载配置模块
require("settings")   -- 基础设置
require("keymaps")    -- 快捷键
require("plugins")    -- 插件管理（含 lazy.nvim 初始化）
require("lsp")        -- LSP 配置
require("autocmds")   -- 自动命令
