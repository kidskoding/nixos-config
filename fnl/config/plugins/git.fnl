(vim.pack.add ["https://github.com/MunifTanjim/nui.nvim"
               "https://github.com/lewis6991/gitsigns.nvim"
               "https://github.com/clabby/difftastic.nvim"
               "https://github.com/sindrets/diffview.nvim"
               "https://github.com/akinsho/git-conflict.nvim"])

(local gitsigns (require :gitsigns))
(local difftastic (require :difftastic-nvim))
(local diffview (require :diffview))
(local git-conflict (require :git-conflict))

(gitsigns.setup {})
(diffview.setup {})
(git-conflict.setup {})
(difftastic.setup {:vcs :git
                   :snacks_picker {:enabled true}
                   :highlights {:DifftTreeRenamed {:fg "#D2BDF3"}}})

(fn unwrap-tab []
  (each [_ win (ipairs (vim.api.nvim_tabpage_list_wins 0))]
    (tset vim.wo win :wrap false)))

(vim.api.nvim_create_autocmd :FileType
                             {:pattern :difft-tree
                              :callback #(vim.schedule unwrap-tab)})

(fn toggle-difft-tree []
  (each [_ win (ipairs (vim.api.nvim_tabpage_list_wins 0))]
    (when (= (. vim.bo (vim.api.nvim_win_get_buf win) :filetype) :difft-tree)
      (vim.api.nvim_win_set_width win
                                  (if (> (vim.api.nvim_win_get_width win) 1)
                                      1
                                      40))
      (vim.cmd "wincmd ="))))

(vim.keymap.set :n :<leader>gb gitsigns.blame_line {:desc "Blame line"})
(vim.keymap.set :n :<leader>gd :<cmd>Difft<CR> {:desc "Diff changes"})
(vim.keymap.set :n :<leader>gD :<cmd>DifftPick<CR> {:desc "Diff a commit"})
(vim.keymap.set :n :<leader>gt toggle-difft-tree
                {:desc "Toggle diff file tree"})

(vim.keymap.set :n :<leader>gv :<cmd>DiffviewOpen<CR> {:desc "Diffview open"})
(vim.keymap.set :n :<leader>gV :<cmd>DiffviewClose<CR> {:desc "Diffview close"})
(vim.keymap.set :n :<leader>gh "<cmd>DiffviewFileHistory %<CR>"
                {:desc "File history"})
