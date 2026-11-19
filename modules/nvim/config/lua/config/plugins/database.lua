vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
vim.g.db_ui_win_position = "left"
vim.g.db_ui_winwidth = 40
vim.g.db_ui_execute_on_save = 0

local function map(key, cmd, desc) vim.keymap.set("n", key, "<cmd>" .. cmd .. "<CR>", { desc = desc }) end

map("<leader>du", "DBUIToggle", "toggle database ui")
map("<leader>da", "DBUIAddConnection", "add database connection")
map("<leader>df", "DBUIFindBuffer", "find database buffer")
map("<leader>dr", "DBUIRenameBuffer", "rename database buffer")
map("<leader>dq", "DBUILastQueryInfo", "last query info")
