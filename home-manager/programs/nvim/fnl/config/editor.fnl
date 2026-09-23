(vim.pack.add ["https://github.com/windwp/nvim-autopairs"
               "https://github.com/NMAC427/guess-indent.nvim"
               "https://github.com/lewis6991/gitsigns.nvim"
               "https://github.com/stevearc/oil.nvim"
               "https://github.com/nvim-lua/plenary.nvim"
               "https://github.com/NeogitOrg/neogit"
               "https://github.com/vyfor/cord.nvim"])

(local autopairs (require :nvim-autopairs))
(local guess-indent (require :guess-indent))
(local gitsigns (require :gitsigns))
(local oil (require :oil))
(local neogit (require :neogit))
(local cord (require :cord))

(autopairs.setup {})
(guess-indent.setup {})
(gitsigns.setup {})
(oil.setup {:win_options {:cursorline true}})
(neogit.setup {})

;; discord rich presence
(cord.setup {:variables true
             :text {:viewing "eyeing up ${filename}"
                    :editing "actively cooking in ${filename}"
                    :workspace "locked in: ${workspace}"}
             :editor {:tooltip "not vscode lmao"}
             :idle {:details "currently touching grass"}})

(vim.keymap.set :n "-" :<cmd>Oil<CR> {:desc "Browse parent directory"})
(vim.keymap.set :n :<leader>gg :<cmd>Neogit<CR> {:desc "Git status"})
(vim.keymap.set :n :<leader>gb gitsigns.blame_line {:desc "Blame line"})
(vim.keymap.set :n :<leader>gc "<cmd>Neogit commit<CR>" {:desc "Git commit"})

;; auto-save after leaving insert mode or any other textedit
(vim.api.nvim_create_autocmd [:InsertLeave :TextChanged]
                             {:callback #(when (= vim.bo.buftype "")
                                           (vim.cmd "silent! update"))})
