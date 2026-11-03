vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_win_position = "left"
vim.g.db_ui_winwidth = 40
vim.g.db_ui_execute_on_save = 0

local function map(key, cmd, desc) vim.keymap.set("n", key, "<cmd>" .. cmd .. "<CR>", { desc = desc }) end

map("<leader>Du", "DBUIToggle", "Toggle database UI")
map("<leader>Da", "DBUIAddConnection", "Add database connection")
map("<leader>Df", "DBUIFindBuffer", "Find database buffer")
map("<leader>Dr", "DBUIRenameBuffer", "Rename database buffer")
map("<leader>Dq", "DBUILastQueryInfo", "Last query info")
