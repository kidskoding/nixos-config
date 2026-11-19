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

map("<leader>nr", "<cmd>RenderMarkdown toggle<CR>", "toggle markdown render")
map("<leader>nm", "<cmd>RenderMarkdown preview<CR>", "markdown preview split")

map("-", "<cmd>Oil<CR>", "browse parent directory")
map("<leader>mm", function() harpoon:list():add() end, "harpoon file")
map("<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, "harpoon menu")

for i, key in ipairs({ "<C-h>", "<C-j>", "<C-k>", "<C-l>" }) do
  map(key, function() harpoon:list():select(i) end, "harpoon file " .. i)
end
