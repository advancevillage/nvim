require("CopilotChat").setup({
  model = "gpt-5.1-codex-max",
  window = {
    layout = 'float',
    width = 90,
    height = 30,
    border = 'rounded',
    title = '🤖 AI Assistant',
    zindex = 100,
  },
  headers = {
    user = '👤',
    assistant = '🤖',
    tool = '🔧',
  },
  separator = '-',
  auto_fold = true,
})

local map = vim.keymap.set
map("n", "<leader>cc", "<cmd>CopilotChatToggle<cr>", { desc = "CHAT" })
map("v", "<leader>cf", "<cmd>CopilotChatFix<cr>",    { desc = "FIX" })
map("n", "<leader>cr", function()
  require("CopilotChat").ask(
    [[
请用中文审查 git 变更，用纯文本输出，禁止使用任何 Markdown 符号（无 #、*、`、---、| 等）：(直接出结果)
【严重问题】（必须修复）
格式：文件名:行号  问题描述  →  修复建议
若无则不显示【严重问题】

【改进建议】（建议优化）(列出文件改动)
格式：文件名:行号  问题描述  →  优化建议
若无则不显示【改进建议】

【值得肯定】
若有则列出写得好的地方
若无则不显示【值得肯定】

总结
结论：可合并 / 需修复后合并 / 不建议合并
理由：一句话说明原因
    ]],
    {
      sticky = { "#gitdiff:unstaged" },
    }
  )
end, { desc = "Copilot: Review Unstaged Diff" })
