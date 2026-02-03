vim.g.lspconfig_suppress_deprecation_warnings = true
local lspconfig = require('lspconfig')

-- 1. 关键：获取 nvim-cmp 的补全能力支持
-- 如果没有这一步，gopls 不会主动向编辑器发送补全候选词
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- 2. 通用 on_attach 函数
local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', '<Leader>gb', '<C-o>', opts)
  vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<Leader>gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<Leader>gh', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
end

-- 3. 配置 Golang LSP (gopls)
lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities, -- 必须添加：将补全能力传递给服务器
  settings = {
    gopls = {
      semanticTokens = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
      -- 增强补全配置
      completeUnimported = true, -- 自动补全未导入的包，并在确认后自动 import
      usePlaceholders = true,    -- 补全函数时自动带上参数占位符
      deepCompletion = true,     -- 深度补全，输入 "." 时更智能
    },
  },
})

-- 4. 自动处理：保存时整理 import 并格式化
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    for client_id, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(client_id) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})
