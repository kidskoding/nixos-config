local flavor = "macchiato"
local p = require("catppuccin.palettes").get_palette(flavor)

require("catppuccin").setup({
  flavour = flavor,
  no_italic = true,

  custom_highlights = function(c)
    return {
      -- treesitter: brackets and delimiters in plain fg
      ["@punctuation.bracket"] = { fg = c.text },
      ["@punctuation.delimiter"] = { fg = c.text },

      -- trouble: match editor background
      TroubleNormal = { link = "Normal" },
      TroubleNormalNC = { link = "Normal" },

      -- gitsigns: untracked in teal
      GitSignsUntracked = { fg = c.teal },

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
local lualine = require("lualine.themes.catppuccin-" .. flavor)
return { lualine = lualine, muted = p.subtext0 }
