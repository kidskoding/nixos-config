local sidekick_cli = require("sidekick.cli")

require("claudecode").setup({
  terminal = {
    split_width_percentage = 0.3,
    snacks_win_opts = { wo = { winbar = "" } },
  },
})

require("sidekick").setup({
  nes = { enabled = false },
  cli = {
    win = { split = { width = 0.3 } },
    tools = { agy = { cmd = { "agy" }, is_proc = "\\<agy" } },
  },
})

local function map(key, cmd, desc) vim.keymap.set("n", key, "<cmd>" .. cmd .. "<CR>", { desc = desc }) end

map("<leader>aa", "ClaudeCode", "Toggle Claude Code")
map("<leader>ar", "ClaudeCode --resume", "Resume Claude session")
map("<leader>aC", "ClaudeCode --continue", "Continue last Claude session")
map("<leader>ay", "ClaudeCodeDiffAccept", "Accept Claude Code diff")
map("<leader>an", "ClaudeCodeDiffDeny", "Deny Claude Code diff")
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<CR>", { desc = "Send selection to Claude Code" })

vim.keymap.set("n", "<leader>at", function() sidekick_cli.toggle() end, { desc = "Toggle agent CLI" })
