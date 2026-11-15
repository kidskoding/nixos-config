local flavour = "mocha"
local p = require("catppuccin.palettes").get_palette(flavour)

require("catppuccin").setup({
  flavour = flavour,
  no_italic = true,

  custom_highlights = function(c)
    return {
      -- treesitter: brackets and delimiters in plain fg
      ["@punctuation.bracket"] = { fg = c.text },
      ["@punctuation.delimiter"] = { fg = c.text },

      -- trouble: match editor background
      TroubleNormal = { link = "Normal" },
      TroubleNormalNC = { link = "Normal" },

      -- gitsigns: change in yellow, untracked in teal
      GitSignsChange = { fg = c.yellow },
      GitSignsUntracked = { fg = c.teal },

      -- sign column on editor bg
      SignColumn = { link = "Normal" },

      -- snacks dashboard menu: neutral so ferris stands out
      SnacksDashboardIcon = { fg = c.blue },
      SnacksDashboardDesc = { fg = c.blue },
      SnacksDashboardKey = { fg = c.text },
      SnacksDashboardDir = { fg = c.overlay1 },
      SnacksDashboardTitle = { fg = c.overlay1 },
      SnacksDashboardFerris = { fg = c.peach },
      SnacksDashboardFerrisAlt = { fg = c.text },
      SnacksDashboardVersion = { fg = c.surface2 },

      -- snacks picker title toggles as badges
      SnacksPickerToggle = { fg = c.blue, bg = c.surface1, bold = true },
    }
  end,
})

vim.cmd.colorscheme("catppuccin")

local lualine = require("lualine.themes.catppuccin-" .. flavour)

lualine.normal.a.bg = p.yellow
lualine.terminal = { a = { bg = p.mauve, fg = p.base, gui = "bold" } }

return { lualine = lualine, muted = p.subtext0 }
