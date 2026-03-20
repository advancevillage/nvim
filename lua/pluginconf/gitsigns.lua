-- ~/.config/nvim/lua/pluginconf/gitsigns.lua
local ok, gitsigns = pcall(require, "gitsigns")
if not ok then return end

local function on_attach(bufnr)
  local gs = package.loaded.gitsigns

  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  -- 提交记录
  map("n", "<leader>hb", gs.blame, "Blame whole file")
  -- 修改Diff
  map("n", "<leader>hd", function() gs.diffthis("master") end, "Diff vs master")
end

gitsigns.setup({
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 250,
    ignore_whitespace = true,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d %H:%M> • <summary>",
  on_attach = on_attach,
})
