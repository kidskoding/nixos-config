local harpoon = require("harpoon")

require("nvim-autopairs").setup({})
require("guess-indent").setup({})
require("nvim-surround").setup({})
require("render-markdown").setup({ enabled = false, latex = { enabled = false } })
require("oil").setup({ win_options = { cursorline = true } })
harpoon:setup({ settings = { save_on_toggle = true } })

require("auto-save").setup({
  condition = function(buf) return vim.bo[buf].buftype == "" and vim.bo[buf].filetype ~= "gitcommit" end,
  trigger_events = { defer_save = { "InsertLeave", "TextChanged", "TextChangedI" } },
})

local function map(key, action, desc) vim.keymap.set("n", key, action, { desc = desc }) end

map("<leader>mr", "<cmd>RenderMarkdown toggle<CR>", "Toggle Markdown render")
map("<leader>mp", "<cmd>RenderMarkdown preview<CR>", "Markdown preview split")

map("-", "<cmd>Oil<CR>", "Browse parent directory")
map("<leader>H", function() harpoon:list():add() end, "Harpoon file")
map("<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "Harpoon menu")

for i, key in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>" }) do
  map(key, function() harpoon:list():select(i) end, "Harpoon file " .. i)
end
