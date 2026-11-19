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

map("<leader>nf", "Obsidian quick_switch", "find note")
map("<leader>ns", "Obsidian search", "search notes")
map("<leader>nn", "Obsidian new", "new note")
map("<leader>nd", "Obsidian today", "daily note")
map("<leader>nb", "Obsidian backlinks", "backlinks")
map("<leader>nt", "Obsidian tags", "search tags")
