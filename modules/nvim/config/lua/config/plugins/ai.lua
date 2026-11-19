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

map("<leader>ac", "ClaudeCode", "toggle claude code")
map("<leader>ar", "ClaudeCode --resume", "resume claude session")
map("<leader>al", "ClaudeCode --continue", "continue last claude session")
map("<leader>ay", "ClaudeCodeDiffAccept", "accept claude code diff")
map("<leader>an", "ClaudeCodeDiffDeny", "deny claude code diff")
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<CR>", { desc = "send selection to claude code" })

vim.keymap.set("n", "<leader>at", function() sidekick_cli.toggle() end, { desc = "toggle agent cli" })
vim.keymap.set("n", "<leader>ad", function() sidekick_cli.close() end, { desc = "detach agent cli session" })
