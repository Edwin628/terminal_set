-- Neovim LSP 配置
-- 语言服务器协议配置

-- 设置 Mason
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",      -- Lua
    "pyright",     -- Python
    "tsserver",    -- TypeScript/JavaScript
    "gopls",       -- Go
    "rust_analyzer", -- Rust
    "clangd",      -- C/C++
    "jdtls",       -- Java
    "html",        -- HTML
    "cssls",       -- CSS
    "jsonls",      -- JSON
    "yamlls",      -- YAML
    "bashls",      -- Bash
    "dockerls",    -- Docker
  },
})

-- LSP 配置函数
local on_attach = function(client, bufnr)
  -- 启用缓冲区本地键映射
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  -- 基础 LSP 键映射
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
  vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>ds", vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, bufopts)
  vim.keymap.set("n", "<leader>i", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<leader>d[", vim.diagnostic.goto_prev, bufopts)
  vim.keymap.set("n", "<leader>d]", vim.diagnostic.goto_next, bufopts)
  vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, bufopts)

  -- 设置缓冲区选项
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- 设置缓冲区本地选项
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- 禁用某些格式化器以避免冲突
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
end

-- 获取 LSP 配置
local lspconfig = require("lspconfig")

-- ================================
-- Lua LSP 配置
-- ================================
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- ================================
-- Python LSP 配置
-- ================================
lspconfig.pyright.setup({
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
})

-- ================================
-- TypeScript/JavaScript LSP 配置
-- ================================
lspconfig.tsserver.setup({
  on_attach = on_attach,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- ================================
-- Go LSP 配置
-- ================================
lspconfig.gopls.setup({
  on_attach = on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

-- ================================
-- Rust LSP 配置
-- ================================
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

-- ================================
-- C/C++ LSP 配置
-- ================================
lspconfig.clangd.setup({
  on_attach = on_attach,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
  },
})

-- ================================
-- Java LSP 配置
-- ================================
lspconfig.jdtls.setup({
  on_attach = on_attach,
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/usr/lib/jvm/java-11-openjdk",
          },
        },
      },
    },
  },
})

-- ================================
-- HTML LSP 配置
-- ================================
lspconfig.html.setup({
  on_attach = on_attach,
  filetypes = { "html", "htm" },
})

-- ================================
-- CSS LSP 配置
-- ================================
lspconfig.cssls.setup({
  on_attach = on_attach,
  filetypes = { "css", "scss", "less" },
})

-- ================================
-- JSON LSP 配置
-- ================================
lspconfig.jsonls.setup({
  on_attach = on_attach,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

-- ================================
-- YAML LSP 配置
-- ================================
lspconfig.yamlls.setup({
  on_attach = on_attach,
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
      },
    },
  },
})

-- ================================
-- Bash LSP 配置
-- ================================
lspconfig.bashls.setup({
  on_attach = on_attach,
})

-- ================================
-- Docker LSP 配置
-- ================================
lspconfig.dockerls.setup({
  on_attach = on_attach,
})

-- ================================
-- 诊断配置
-- ================================
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

-- 设置诊断符号
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end 