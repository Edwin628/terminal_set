-- Neovim 自动命令
-- 定义各种自动执行的命令

local api = vim.api

-- 创建自动命令组
local augroup = api.nvim_create_augroup
local autocmd = api.nvim_create_autocmd

-- ================================
-- 文件类型相关
-- ================================

-- 为特定文件类型设置缩进
augroup("FileTypeIndent", { clear = true })
autocmd("FileType", {
  group = "FileTypeIndent",
  pattern = {
    "lua",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "json",
    "yaml",
    "html",
    "css",
    "scss",
    "less",
    "python",
    "go",
    "rust",
    "c",
    "cpp",
    "java",
    "php",
    "ruby",
    "sh",
    "bash",
    "zsh",
    "fish",
    "markdown",
    "tex",
    "vim",
  },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- 为特定文件类型设置不同的缩进
augroup("SpecialIndent", { clear = true })
autocmd("FileType", {
  group = "SpecialIndent",
  pattern = { "python", "go", "rust", "c", "cpp", "java" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- ================================
-- 保存相关
-- ================================

-- 自动保存
augroup("AutoSave", { clear = true })
autocmd("TextChanged", {
  group = "AutoSave",
  pattern = "*",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})

-- 保存时自动格式化
augroup("AutoFormat", { clear = true })
autocmd("BufWritePre", {
  group = "AutoFormat",
  pattern = {
    "*.lua",
    "*.js",
    "*.ts",
    "*.jsx",
    "*.tsx",
    "*.json",
    "*.yaml",
    "*.yml",
    "*.html",
    "*.css",
    "*.scss",
    "*.less",
    "*.py",
    "*.go",
    "*.rs",
    "*.c",
    "*.cpp",
    "*.java",
    "*.php",
    "*.rb",
    "*.sh",
    "*.bash",
    "*.zsh",
    "*.fish",
    "*.md",
    "*.tex",
    "*.vim",
  },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- ================================
-- 界面相关
-- ================================

-- 进入插入模式时隐藏行号
augroup("InsertModeUI", { clear = true })
autocmd("InsertEnter", {
  group = "InsertModeUI",
  callback = function()
    vim.opt.relativenumber = false
  end,
})

autocmd("InsertLeave", {
  group = "InsertModeUI",
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- 高亮当前行
augroup("HighlightLine", { clear = true })
autocmd("WinEnter", {
  group = "HighlightLine",
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

autocmd("WinLeave", {
  group = "HighlightLine",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- ================================
-- 搜索相关
-- ================================

-- 搜索时高亮
augroup("SearchHighlight", { clear = true })
autocmd("CmdlineEnter", {
  group = "SearchHighlight",
  pattern = "/",
  callback = function()
    vim.opt.hlsearch = true
  end,
})

-- 退出搜索时清除高亮
autocmd("CmdlineLeave", {
  group = "SearchHighlight",
  pattern = "/",
  callback = function()
    vim.opt.hlsearch = false
  end,
})

-- ================================
-- 缓冲区相关
-- ================================

-- 新缓冲区设置
augroup("NewBuffer", { clear = true })
autocmd("BufNewFile", {
  group = "NewBuffer",
  callback = function()
    vim.opt_local.buftype = ""
    vim.opt_local.swapfile = false
  end,
})

-- 关闭缓冲区时清理
augroup("BufferCleanup", { clear = true })
autocmd("BufDelete", {
  group = "BufferCleanup",
  callback = function()
    -- 可以在这里添加缓冲区清理逻辑
  end,
})

-- ================================
-- 终端相关
-- ================================

-- 终端设置
augroup("Terminal", { clear = true })
autocmd("TermOpen", {
  group = "Terminal",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.list = false
    vim.opt_local.spell = false
    vim.opt_local.buflisted = false
  end,
})

-- ================================
-- Git 相关
-- ================================

-- Git 提交信息设置
augroup("GitCommit", { clear = true })
autocmd("FileType", {
  group = "GitCommit",
  pattern = { "gitcommit", "gitrebase" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 72
  end,
})

-- ================================
-- 特殊文件类型
-- ================================

-- Markdown 文件设置
augroup("Markdown", { clear = true })
autocmd("FileType", {
  group = "Markdown",
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.textwidth = 80
  end,
})

-- 配置文件设置
augroup("ConfigFiles", { clear = true })
autocmd("FileType", {
  group = "ConfigFiles",
  pattern = { "json", "yaml", "yml", "toml", "ini" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- ================================
-- 性能优化
-- ================================

-- 大文件优化
augroup("LargeFile", { clear = true })
autocmd("BufReadPre", {
  group = "LargeFile",
  callback = function()
    local large_file = 1024 * 1024 -- 1MB
    local file_size = vim.fn.getfsize(vim.fn.expand("%"))
    if file_size > large_file then
      vim.opt_local.eventignore = "all"
      vim.opt_local.syntax = "off"
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.foldlevelstart = 99
      vim.opt_local.lazyredraw = true
      vim.opt_local.updatetime = 4000
    end
  end,
})

-- ================================
-- 其他实用命令
-- ================================

-- 记住上次编辑位置
augroup("LastPosition", { clear = true })
autocmd("BufReadPost", {
  group = "LastPosition",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 自动切换目录
augroup("AutoChdir", { clear = true })
autocmd("BufEnter", {
  group = "AutoChdir",
  callback = function()
    if vim.fn.isdirectory(vim.fn.expand("%")) == 1 then
      vim.cmd("cd %")
    end
  end,
}) 