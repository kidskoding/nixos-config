(vim.pack.add ["https://github.com/windwp/nvim-autopairs"
               "https://github.com/NMAC427/guess-indent.nvim"
               "https://github.com/lewis6991/gitsigns.nvim"
               "https://github.com/stevearc/oil.nvim"
               "https://github.com/nvim-lua/plenary.nvim"
               "https://github.com/NeogitOrg/neogit"])

(local autopairs (require :nvim-autopairs))
(local guess-indent (require :guess-indent))
(local gitsigns (require :gitsigns))
(local oil (require :oil))
(local neogit (require :neogit))

(autopairs.setup {})
(guess-indent.setup {})
(gitsigns.setup {})
(oil.setup {:win_options {:cursorline true}})
(neogit.setup {})

(vim.keymap.set :n "-" :<cmd>Oil<CR> {:desc "Browse parent directory"})
(vim.keymap.set :n :<leader>gg :<cmd>Neogit<CR> {:desc "Git status"})

;; auto-save after leaving insert mode or any other textedit
(vim.api.nvim_create_autocmd [:InsertLeave :TextChanged]
                             {:callback #(when (= vim.bo.buftype "")
                                           (vim.cmd "silent! update"))})
