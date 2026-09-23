(vim.pack.add ["https://github.com/folke/snacks.nvim"])

(local snacks (require :snacks))

(snacks.setup {:bigfile {:enabled true}
               :indent {:enabled true}
               :picker {:enabled true}})

(fn map [key action desc]
  (vim.keymap.set :n key action {: desc}))

(map :<leader><space> #(snacks.picker.files) "Find files")
(map :<leader>/ #(snacks.picker.grep) "Search project")
(map :<leader>e #(snacks.picker.explorer) "File explorer")
(map :<leader>bb #(snacks.picker.buffers) "Switch buffer")
(map :<leader>bd #(snacks.bufdelete) "Close buffer")
(map :<leader>gB #(snacks.gitbrowse) "Open file on GitHub")
(map :gd #(snacks.picker.lsp_definitions) "Go to definition")
(map :grr #(snacks.picker.lsp_references) :References)

;; some terminals send <C-_> for <C-/>
(vim.keymap.set [:n :t] :<C-/> #(snacks.terminal) {:desc "Toggle terminal"})
(vim.keymap.set [:n :t] :<C-_> #(snacks.terminal) {:desc :which_key_ignore})
