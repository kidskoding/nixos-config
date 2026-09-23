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
(map :<leader>h #(snacks.picker.help) "Search help pages")
(map :<leader>bb #(snacks.picker.buffers) "Switch buffer")
(map :<leader>bd #(snacks.bufdelete) "Close buffer")
(map :<leader>gB #(snacks.gitbrowse) "Open file on GitHub")
(map :<leader>gl #(snacks.picker.git_log_file) "File git history")

;; difftastic in one column; LESS=-R keeps small diffs from closing instantly
(local difft {:env {:DFT_DISPLAY :inline :LESS :-R}})
(map :<leader>gd
     #(snacks.terminal [:git :dft "--" (vim.fn.expand "%:p")] difft)
     "Difftastic: current file")
(map :<leader>gD #(snacks.terminal [:git :dft] difft) "Difftastic: whole repo")

(map :gd #(snacks.picker.lsp_definitions) "Go to definition")
(map :grr #(snacks.picker.lsp_references) :References)

;; some terminals send <C-_> for <C-/>
(vim.keymap.set [:n :t] :<C-/> #(snacks.terminal) {:desc "Toggle terminal"})
(vim.keymap.set [:n :t] :<C-_> #(snacks.terminal) {:desc :which_key_ignore})
