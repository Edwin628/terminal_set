-- Neovim 快捷键映射
-- 定义各种编辑、导航和插件快捷键

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ================================
-- 基础快捷键
-- ================================

-- 保存和退出
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
keymap("n", "<leader>Q", ":q!<CR>", opts)

-- 窗口管理
keymap("n", "<leader>sv", ":vsplit<CR>", opts)  -- 垂直分割
keymap("n", "<leader>sh", ":split<CR>", opts)   -- 水平分割
keymap("n", "<leader>sc", ":close<CR>", opts)   -- 关闭窗口
keymap("n", "<leader>so", ":only<CR>", opts)    -- 只保留当前窗口

-- 缓冲区管理
keymap("n", "<leader>bn", ":bnext<CR>", opts)   -- 下一个缓冲区
keymap("n", "<leader>bp", ":bprevious<CR>", opts) -- 上一个缓冲区
keymap("n", "<leader>bd", ":bdelete<CR>", opts) -- 删除缓冲区

-- 标签页管理
keymap("n", "<leader>tn", ":tabnew<CR>", opts)  -- 新建标签页
keymap("n", "<leader>tc", ":tabclose<CR>", opts) -- 关闭标签页
keymap("n", "<leader>tl", ":tabnext<CR>", opts) -- 下一个标签页
keymap("n", "<leader>th", ":tabprevious<CR>", opts) -- 上一个标签页

-- ================================
-- 编辑快捷键
-- ================================

-- 快速移动
keymap("n", "J", "mzJ`z", opts)                 -- 合并行
keymap("n", "<C-d>", "<C-d>zz", opts)           -- 向下滚动并居中
keymap("n", "<C-u>", "<C-u>zz", opts)           -- 向上滚动并居中
keymap("n", "n", "nzzzv", opts)                 -- 搜索时保持光标居中
keymap("n", "N", "Nzzzv", opts)                 -- 反向搜索时保持光标居中

-- 复制粘贴
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)      -- 向下移动选中行
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)      -- 向上移动选中行
keymap("n", "<leader>y", "\"+y", opts)          -- 复制到系统剪贴板
keymap("v", "<leader>y", "\"+y", opts)          -- 复制到系统剪贴板
keymap("n", "<leader>Y", "gg\"+yG", opts)       -- 复制整个文件
keymap("n", "<leader>p", "\"+p", opts)          -- 从系统剪贴板粘贴
keymap("v", "<leader>p", "\"+p", opts)          -- 从系统剪贴板粘贴

-- 撤销重做
keymap("n", "U", "<C-r>", opts)                 -- 重做

-- 搜索
keymap("n", "<leader>nh", ":nohl<CR>", opts)    -- 清除搜索高亮

-- ================================
-- 插件快捷键（将在插件加载后生效）
-- ================================

-- 文件浏览器
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- 模糊搜索
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)

-- LSP 快捷键
keymap("n", "gd", vim.lsp.buf.definition, opts)           -- 跳转到定义
keymap("n", "gr", vim.lsp.buf.references, opts)           -- 查找引用
keymap("n", "K", vim.lsp.buf.hover, opts)                 -- 悬停文档
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)  -- 代码操作
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)       -- 重命名
keymap("n", "<leader>f", vim.lsp.buf.format, opts)        -- 格式化

-- 调试快捷键
keymap("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>dc", ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<leader>di", ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<leader>do", ":lua require'dap'.step_over()<CR>", opts)

-- ================================
-- 终端快捷键
-- ================================

-- 在终端模式下的快捷键
keymap("t", "<Esc>", "<C-\\><C-n>", opts)       -- 退出终端模式
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", opts) -- 切换到左窗口
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", opts) -- 切换到下窗口
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", opts) -- 切换到上窗口
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", opts) -- 切换到右窗口

-- ================================
-- 其他快捷键
-- ================================

-- 快速保存所有文件
keymap("n", "<leader>wa", ":wa<CR>", opts)

-- 重新加载配置
keymap("n", "<leader>rc", ":source ~/.config/nvim/init.lua<CR>", opts)

-- 打开配置文件
keymap("n", "<leader>cf", ":e ~/.config/nvim/init.lua<CR>", opts)

-- 切换行号
keymap("n", "<leader>n", ":set number!<CR>", opts)

-- 切换相对行号
keymap("n", "<leader>rn", ":set relativenumber!<CR>", opts)

-- 切换拼写检查
keymap("n", "<leader>s", ":set spell!<CR>", opts)

-- 快速跳转到行首行尾
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)

-- 在单词间快速跳转
keymap("n", "W", "b", opts)
keymap("n", "B", "w", opts)
keymap("v", "W", "b", opts)
keymap("v", "B", "w", opts) 