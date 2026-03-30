require("CopilotChat").setup({
  window = {
    width = 0.3,
    height = 1.0,
    border = "rounded",
    position = "right",                 
    title    = "CopilotChat",           
    title_pos= "center",
  },
  mappings = {
    reset = {
      normal = "<C-r>",
      insert = "<C-r>",
    },
  },
})

local map = vim.keymap.set
map("n", "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "CHAT" })
map("v", "<leader>cf", "<cmd>CopilotChatFix<cr>",    { desc = "FIX" })
map("v", "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "CR" })
