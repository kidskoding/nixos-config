local gitsigns = require("gitsigns")

gitsigns.setup({})

vim.keymap.set("n", "<leader>gb", gitsigns.blame_line, { desc = "Blame line" })
