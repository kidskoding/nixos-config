local gruvbox = require("gruvbox")

gruvbox.setup({
  -- medium
  contrast = "",

  italic = {
    strings = false,
    emphasis = false,
    comments = false,
    operators = false,
    folds = false,
  },

  overrides = {
    -- treesitter: brackets and delimiters in plain fg
    ["@punctuation.bracket"] = { link = "GruvboxFg1" },
    ["@punctuation.delimiter"] = { link = "GruvboxFg1" },

    -- trouble: match editor background
    TroubleNormal = { link = "Normal" },
    TroubleNormalNC = { link = "Normal" },

    -- diff colors
    Added = { link = "GruvboxGreen" },
    Removed = { link = "GruvboxRed" },
    Changed = { link = "GruvboxYellow" },

    -- gitsigns: change in yellow, untracked in aqua
    GitSignsChange = { link = "GruvboxYellow" },
    GitSignsUntracked = { link = "GruvboxAqua" },

    -- sign column and signs on editor bg, not bg1
    SignColumn = { link = "Normal" },
    GruvboxRedSign = { link = "GruvboxRed" },
    GruvboxGreenSign = { link = "GruvboxGreen" },
    GruvboxYellowSign = { link = "GruvboxYellow" },
    GruvboxBlueSign = { link = "GruvboxBlue" },
    GruvboxPurpleSign = { link = "GruvboxPurple" },
    GruvboxAquaSign = { link = "GruvboxAqua" },
    GruvboxOrangeSign = { link = "GruvboxOrange" },

    -- snacks dashboard menu: neutral so ferris stands out
    SnacksDashboardIcon = { link = "GruvboxBlue" },
    SnacksDashboardDesc = { link = "GruvboxBlue" },
    SnacksDashboardKey = { link = "GruvboxFg1" },
    SnacksDashboardDir = { link = "GruvboxGray" },
    SnacksDashboardTitle = { link = "GruvboxGray" },
    SnacksDashboardFerris = { link = "GruvboxOrange" },
    SnacksDashboardFerrisAlt = { link = "GruvboxFg0" },
    SnacksDashboardVersion = { link = "GruvboxBg4" },

    -- snacks picker title toggles as badges
    SnacksPickerToggle = {
      fg = gruvbox.palette.bright_blue,
      bg = gruvbox.palette.dark2,
      bold = true,
    },
  },
})

vim.cmd.colorscheme("gruvbox")

local p = gruvbox.palette
local lualine = require("lualine.themes.gruvbox_dark")
lualine.normal.a.bg = p.neutral_yellow
-- brighter middle text; the theme's muted gray is hard to read on the bar
lualine.normal.c.fg = p.light2
lualine.terminal = { a = { bg = p.bright_purple, fg = p.dark0, gui = "bold" } }

return { lualine = lualine, muted = p.light4 }
