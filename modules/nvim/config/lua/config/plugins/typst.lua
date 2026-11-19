-- use tinymist and websocat from PATH instead of downloading them
require("typst-preview").setup({
  dependencies_bin = { tinymist = "tinymist", websocat = "websocat" },
})

local function map(key, action, desc) vim.keymap.set("n", key, action, { desc = desc }) end

map("<leader>np", "<cmd>TypstPreviewToggle<CR>", "toggle typst preview")
map("<leader>ne", "<cmd>make | silent !xdg-open %:r.pdf &<CR>", "export typst pdf")
