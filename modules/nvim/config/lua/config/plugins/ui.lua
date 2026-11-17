require("nvim-highlight-colors").setup({ render = "background", enable_tailwind = true })

local colors = require("config.theme")
local theme = colors.lualine
for _, section in pairs(theme) do
  section.b = section.b or theme.normal.b
  section.c = theme.normal.c
end

local bar_bg, raised_bg = theme.normal.c.bg, theme.normal.b.bg

vim.api.nvim_set_hl(0, "lualine_sep_color_b", { fg = colors.muted, bg = raised_bg })
vim.api.nvim_set_hl(0, "lualine_sep_color_x", { fg = colors.muted, bg = bar_bg })

require("lualine").setup({
  options = {
    theme = theme,
    globalstatus = true,
    ignore_focus = { "snacks_picker_list", "snacks_picker_input", "snacks_terminal" },
    component_separators = { left = "%#lualine_sep_color_b#│", right = "%#lualine_sep_color_x#│" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_b = { { "branch", separator = "" }, "diff" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "lsp_status", { "diagnostics", sections = { "error", "warn" } }, "filetype" },
    lualine_y = { "selectioncount" },
  },
})

local p = colors.palette
local fill_bg, tab_bg, active_bg = p.mantle, p.base, p.surface0

local buffer_highlights = {
  fill = { bg = fill_bg },
  trunc_marker = { bg = fill_bg },
  background = { fg = p.overlay2, bg = tab_bg },
  buffer_visible = { fg = p.overlay2, bg = tab_bg },
  buffer_selected = { fg = p.text, bg = active_bg, bold = true },
  indicator_visible = { bg = tab_bg },
  indicator_selected = { bg = active_bg },
}

-- every piece of a tab sits on that tab's background, like astronvim's heirline tabline
for _, part in ipairs({
  "close_button",
  "modified",
  "duplicate",
  "numbers",
  "pick",
  "separator",
  "diagnostic",
  "hint",
  "info",
  "warning",
  "error",
  "hint_diagnostic",
  "info_diagnostic",
  "warning_diagnostic",
  "error_diagnostic",
}) do
  buffer_highlights[part] = { bg = tab_bg }
  buffer_highlights[part .. "_visible"] = { bg = tab_bg }
  buffer_highlights[part .. "_selected"] = { bg = active_bg }
end

local bufferline = require("bufferline")
bufferline.setup({
  options = {
    style_preset = { bufferline.style_preset.minimal, bufferline.style_preset.no_italic },
    tab_size = 0,
    indicator = { style = "none" },
    separator_style = { "", "" },
    offsets = { { filetype = "snacks_layout_box", separator = false, highlight = "NormalFloat" } },
  },
  highlights = buffer_highlights,
})

-- leader group names. groups with no keymaps yet stay hidden
require("which-key").setup({
  icons = {
    rules = {
      { pattern = "claude", icon = "󱚣 ", color = "orange" },
      { pattern = "agent", icon = " ", color = "purple" },
    },
  },
  spec = {
    { "<leader>a", group = "ai", icon = { icon = "󱚣 ", color = "orange" } },
    { "<leader>b", group = "buffers", icon = "󰓩 " },
    { "<leader>c", group = "code", icon = " " },
    { "<leader>D", group = "database", icon = " " },
    { "<leader>g", group = "git", icon = "󰊢 " },
    { "<leader>m", group = "markdown", icon = " " },
    { "<leader>o", group = "obsidian", icon = "󰠮 " },
    { "<leader>r", group = "rust", icon = { icon = " ", color = "orange" } },
    { "<leader>t", group = "test", icon = "󰙨 " },
    { "<leader>T", group = "typst", icon = "󰈙 " },
    { "<leader>x", group = "lists", icon = " " },
  },
})

vim.api.nvim_set_hl(0, "WhichKeyIcon", { fg = "#B2CAED" })
