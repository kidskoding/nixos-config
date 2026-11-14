vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_disable_italic_comment = 1
vim.g.gruvbox_material_sign_column_background = "none"

local config = vim.fn["gruvbox_material#get_configuration"]()
local palette = vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
local function color(name) return palette[name][1] end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "gruvbox-material",
  callback = function()
    local overrides = {
      ["@punctuation.bracket"] = { link = "Fg" },
      ["@punctuation.delimiter"] = { link = "Fg" },

      TroubleNormal = { link = "Normal" },
      TroubleNormalNC = { link = "Normal" },

      Added = { link = "Green" },
      Removed = { link = "Red" },
      Changed = { link = "Yellow" },

      GitSignsChange = { link = "Yellow" },
      GitSignsUntracked = { link = "Aqua" },

      -- snacks dashboard menu: neutral so ferris stands out
      SnacksDashboardIcon = { link = "Blue" },
      SnacksDashboardDesc = { link = "Blue" },
      SnacksDashboardKey = { link = "Fg" },
      SnacksDashboardDir = { link = "Grey" },
      SnacksDashboardTitle = { link = "Grey" },
      SnacksDashboardFerris = { link = "Orange" },
      SnacksDashboardFerrisAlt = { link = "Fg" },
      SnacksDashboardVersion = { fg = color("bg5") },

      -- snacks picker title toggles as badges
      SnacksPickerToggle = { fg = color("blue"), bg = color("bg3"), bold = true },
    }
    for group, hl in pairs(overrides) do
      vim.api.nvim_set_hl(0, group, hl)
    end
  end,
})

vim.cmd.colorscheme("gruvbox-material")

local lualine = require("lualine.themes.gruvbox-material")
lualine.normal.a.bg = color("yellow")
lualine.terminal = { a = { bg = color("purple"), fg = color("bg0"), gui = "bold" } }

return { lualine = lualine, muted = color("grey2") }
