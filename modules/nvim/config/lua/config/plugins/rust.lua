vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        check = { command = "clippy" },
      },
    },
  },
}

require("crates").setup({
  lsp = { enabled = true, actions = true, completion = true, hover = true },
  completion = { crates = { enabled = true, max_results = 8, min_chars = 3 } },
})

local function map(key, cmd, desc) vim.keymap.set("n", key, "<cmd>" .. cmd .. "<CR>", { desc = desc }) end

map("<leader>ra", "RustLsp codeAction", "Rust code action")
map("<leader>rr", "RustLsp runnables", "Rust runnables")
map("<leader>rt", "RustLsp testables", "Rust testables")
map("<leader>re", "RustLsp explainError", "Explain Rust error")
