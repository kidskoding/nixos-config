(vim.pack.add ["https://github.com/windwp/nvim-autopairs"
               "https://github.com/NMAC427/guess-indent.nvim"
               "https://github.com/lewis6991/gitsigns.nvim"
               "https://github.com/stevearc/oil.nvim"
               "https://github.com/nvim-lua/plenary.nvim"
               "https://github.com/NeogitOrg/neogit"
               "https://github.com/MunifTanjim/nui.nvim"
               "https://github.com/clabby/difftastic.nvim"
               "https://github.com/okuuva/auto-save.nvim"
               "https://github.com/vyfor/cord.nvim"])

(local autopairs (require :nvim-autopairs))
(local guess-indent (require :guess-indent))
(local gitsigns (require :gitsigns))
(local oil (require :oil))
(local neogit (require :neogit))
(local difftastic (require :difftastic-nvim))
(local auto-save (require :auto-save))
(local cord (require :cord))

(autopairs.setup {})
(guess-indent.setup {})
(gitsigns.setup {})
(oil.setup {:win_options {:cursorline true}})
(neogit.setup {})
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

(fn autosave? [buf]
  (and (= (. vim.bo buf :buftype) "")
       (not (vim.tbl_contains [:gitcommit :NeogitCommitMessage]
                              (. vim.bo buf :filetype)))))

(auto-save.setup {:condition autosave?
                  :trigger_events {:defer_save [:InsertLeave
                                                :TextChanged
                                                :TextChangedI]}})

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
(vim.keymap.set :n :<leader>gd :<cmd>Difft<CR> {:desc "Diff changes"})
(vim.keymap.set :n :<leader>gD :<cmd>DifftPick<CR> {:desc "Diff a commit"})
(vim.keymap.set :n :<leader>gt toggle-difft-tree
                {:desc "Toggle diff file tree"})
