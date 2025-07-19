-- Neovim 主配置文件
-- 作者: AI Assistant
-- 描述: 现代化 Neovim 配置，适合开发使用

-- 设置 leader 键为空格
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 基础设置
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"  -- 使用系统剪贴板

-- 快捷键
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)

-- 剪贴板快捷键
keymap("n", "<leader>y", "\"+y", opts)          -- 复制到系统剪贴板
keymap("v", "<leader>y", "\"+y", opts)          -- 复制选中内容到系统剪贴板
keymap("n", "<leader>Y", "gg\"+yG", opts)       -- 复制整个文件到系统剪贴板
keymap("n", "<leader>p", "\"+p", opts)          -- 从系统剪贴板粘贴
keymap("v", "<leader>p", "\"+p", opts)          -- 从系统剪贴板粘贴

-- 插件管理器
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 插件配置
require("lazy").setup({
  -- 主题
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  
  -- 文件浏览器
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
  },
  
  -- 模糊搜索
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  
  -- 语法高亮
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },
  
  -- Mason 配置
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",      -- Lua
          "pyright",     -- Python
          "tsserver",    -- TypeScript/JavaScript
          "gopls",       -- Go
          "rust_analyzer", -- Rust
          "clangd",      -- C/C++
          "html",        -- HTML
          "cssls",       -- CSS
          "jsonls",      -- JSON
          "yamlls",      -- YAML
          "bashls",      -- Bash
        },
      })
    end,
  },
  
  -- 自动补全
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
  },
}) 
