-- ~/.config/nvim/lua/pluginconf/lazygit.lua
vim.g.lazygit_floating_window_scaling_factor = 0.9
vim.g.lazygit_use_neovim_remote = 0

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>lg",  "<cmd>LazyGit<cr>",            opts)
vim.keymap.set("n", "<leader>lgf", "<cmd>LazyGitCurrentFile<cr>", opts)
