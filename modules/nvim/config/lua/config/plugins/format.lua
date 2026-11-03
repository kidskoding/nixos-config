local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    fennel = { "fnlfmt" },
    lua = { "stylua" },
    nix = { "alejandra" },
    python = { "ruff_organize_imports", "ruff_format" },
    typst = { "typstyle" },
  },
})

vim.keymap.set(
  "n",
  "<leader>cf",
  function() conform.format({ lsp_format = "fallback" }) end,
  { desc = "Format buffer" }
)
