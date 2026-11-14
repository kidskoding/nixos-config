require("nvim-highlight-colors").setup({ render = "background", enable_tailwind = true })

local colors = require("config.themes")
local theme = colors.lualine
for _, section in pairs(theme) do
  section.b = section.b or theme.normal.b
  section.c = theme.normal.c
end

local bar_bg, raised_bg, text_fg = theme.normal.c.bg, theme.normal.b.bg, theme.normal.b.fg

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

local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
local active_bg = bar_bg

local buffer_highlights = {
  fill = { bg = normal_bg },
  separator = { fg = raised_bg, bg = normal_bg },
  separator_visible = { fg = raised_bg, bg = normal_bg },
  separator_selected = { fg = raised_bg, bg = normal_bg },
  offset_separator = { bg = normal_bg },
  buffer_selected = { fg = text_fg, bg = active_bg, bold = true },
}

-- every piece of the active tab sits on the same raised background
for _, part in ipairs({ "indicator", "close_button", "modified", "duplicate", "numbers", "pick", "diagnostic" }) do
  buffer_highlights[part .. "_selected"] = { bg = active_bg }
end

for _, level in ipairs({ "hint", "info", "warning", "error" }) do
  buffer_highlights[level .. "_selected"] = { bg = active_bg }
  buffer_highlights[level .. "_diagnostic_selected"] = { bg = active_bg }
end

local bufferline = require("bufferline")
bufferline.setup({
  options = {
    style_preset = { bufferline.style_preset.minimal, bufferline.style_preset.no_italic },
    tab_size = 0,
    indicator = { style = "none" },
    separator_style = "thin",
    offsets = { { filetype = "snacks_layout_box", separator = true, highlight = "Normal" } },
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
