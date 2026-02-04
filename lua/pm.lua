-- ~/.config/nvim/lua/config_lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

-- 自动下载引导
if not uv.fs_stat(lazypath) then
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

-- 启动 lazy
require("lazy").setup("plugins", {
    git = {
        timeout = 300,
        url_format = "https://github.com/%s",
    },
    ui = {
        border = "rounded",
    },
})
