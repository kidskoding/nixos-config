-- obsidian.nvim errors at startup when no workspace path exists, so only
-- keep vaults present on this machine and skip setup when there are none.
local workspaces = vim.tbl_filter(
  function(ws) return vim.fn.isdirectory(vim.fn.expand(ws.path)) == 1 end,
  { { name = "vault", path = "~/Obsidian Vault" } }
)

if #workspaces == 0 then return end

require("obsidian").setup({
  legacy_commands = false,
  workspaces = workspaces,
  picker = { name = "snacks.picker" },
  ui = { enable = false },
  frontmatter = { enabled = false },
})

local function map(key, cmd, desc) vim.keymap.set("n", key, "<cmd>" .. cmd .. "<CR>", { desc = desc }) end

map("<leader>of", "Obsidian quick_switch", "Find note")
map("<leader>os", "Obsidian search", "Search notes")
map("<leader>on", "Obsidian new", "New note")
map("<leader>od", "Obsidian today", "Daily note")
map("<leader>ob", "Obsidian backlinks", "Backlinks")
map("<leader>ot", "Obsidian tags", "Search tags")
