(set vim.g.db_ui_use_nerd_fonts 1)
(set vim.g.db_ui_show_database_icon 1)
(set vim.g.db_ui_win_position :left)
(set vim.g.db_ui_winwidth 40)
(set vim.g.db_ui_execute_on_save 0)

(vim.pack.add ["https://github.com/tpope/vim-dadbod"
               "https://github.com/kristijanhusak/vim-dadbod-ui"
               "https://github.com/kristijanhusak/vim-dadbod-completion"])

(fn map [key cmd desc]
  (vim.keymap.set :n key (.. :<cmd> cmd :<CR>) {: desc}))

(map :<leader>Du :DBUIToggle "Toggle database UI")
(map :<leader>Da :DBUIAddConnection "Add database connection")
(map :<leader>Df :DBUIFindBuffer "Find database buffer")
(map :<leader>Dr :DBUIRenameBuffer "Rename database buffer")
(map :<leader>Dq :DBUILastQueryInfo "Last query info")
