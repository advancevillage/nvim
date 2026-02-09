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
vim.lsp.config('gopls', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = { unusedparams = true },
      staticcheck = true,
      gofumpt = true,
      completeUnimported = true,
      usePlaceholders = true,
      deepCompletion = true,
      semanticTokens = true,
    },
  },
})
vim.lsp.enable('gopls')


-- 4. 自动处理：保存时整理 import 并格式化
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    -- 获取当前 buffer 的 LSP client（通常是 gopls）
    local client = vim.lsp.get_clients({ bufnr = 0 })[1]
    if not client then return end

    -- 明确传入 position_encoding（修复启动警告）
    local params = vim.lsp.util.make_range_params(
      nil,
      client.offset_encoding
    )
    params.context = { only = { "source.organizeImports" } }

    -- 请求 organizeImports
    local result = vim.lsp.buf_request_sync(
      0,
      "textDocument/codeAction",
      params,
      1000
    )

    -- 应用 workspace edit
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(
            r.edit,
            client.offset_encoding
          )
        end
      end
    end

    -- 使用 gopls 进行格式化，避免多 formatter 冲突
    vim.lsp.buf.format({
      async = false,
      filter = function(c)
        return c.name == "gopls"
      end,
    })
  end,
})
