-- lua/plugin_config/lsp.lua
local lspconfig = require("lspconfig")

-- 2. 通用 on_attach 函数，用于在 LSP 启动时绑定快捷键
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- LSP 常用快捷键配置
  -- 注意：这里使用的是 <Leader>gd，如果你习惯直接按 gd，请去掉 <Leader>
  vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<Leader>gdd', vim.cmd.Undojoin or vim.cmd.normal, opts)
  vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<Leader>gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<Leader>gh', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
end

-- 3. 配置 Golang LSP (gopls)
lspconfig.gopls.setup({
  on_attach = on_attach, -- 关键修复：将快捷键绑定函数传递给 gopls
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

-- 4. 自动处理：保存时整理 import 并格式化代码
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }

    -- 同步请求：整理 Imports
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    for client_id, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(client_id) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end

    -- 执行格式化
    vim.lsp.buf.format({ async = false })
  end,
})
