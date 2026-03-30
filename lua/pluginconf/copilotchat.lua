require("CopilotChat").setup({
  window = {
    layout = 'float',
    width = 80, -- Fixed width in columns
    height = 20, -- Fixed height in rows
    border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
    title = '🤖 AI Assistant',
    zindex = 100, -- Ensure window stays on top
  },

  headers = {
    user = '👤',
    assistant = '🤖',
    tool = '🔧',
  },

  separator = '-',
  auto_fold = true, -- Automatically folds non-assistant messages
})

local map = vim.keymap.set
map("n", "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "CHAT" })
map("v", "<leader>cf", "<cmd>CopilotChatFix<cr>",    { desc = "FIX" })
map("v", "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "CR" })
