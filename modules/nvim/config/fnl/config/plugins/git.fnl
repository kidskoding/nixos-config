(vim.pack.add ["https://github.com/lewis6991/gitsigns.nvim"])

(local gitsigns (require :gitsigns))

(gitsigns.setup {})

(vim.keymap.set :n :<leader>gb gitsigns.blame_line {:desc "Blame line"})
