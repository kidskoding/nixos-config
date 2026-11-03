-- sql buffers complete tables and columns from dadbod (database.lua)
local sql_sources = { "dadbod", "snippets", "buffer" }

require("blink.cmp").setup({
  sources = {
    per_filetype = {
      sql = sql_sources,
      mysql = sql_sources,
      plsql = sql_sources,
    },
    providers = {
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
    },
  },
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
  },
  signature = { enabled = true },
  keymap = {
    preset = "none",
    ["<C-j>"] = { "insert_next", "fallback" },
    ["<C-k>"] = { "insert_prev", "fallback" },
    ["<C-y>"] = { "accept", "fallback" },
    ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "snippet_backward", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<C-e>"] = { "cancel", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-l>"] = { "show_signature", "hide_signature", "fallback" },
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  },
})
