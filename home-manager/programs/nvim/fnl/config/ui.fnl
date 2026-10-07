(vim.pack.add ["https://github.com/nvim-lualine/lualine.nvim"
               "https://github.com/nvim-tree/nvim-web-devicons"
               "https://github.com/akinsho/bufferline.nvim"])

;; colors for the │ component separators below
(vim.api.nvim_set_hl 0 :lualine_sep_color_b {:fg "#839E9A" :bg "#262F33"})
(vim.api.nvim_set_hl 0 :lualine_sep_color_x {:fg "#839E9A" :bg "#191E21"})

(local lualine (require :lualine))
(local bufferline (require :bufferline))

(lualine.setup {:options {:theme :evergarden
                          :globalstatus true
                          :component_separators {:left "%#lualine_sep_color_b#│"
                                                 :right "%#lualine_sep_color_x#│"}
                          :section_separators {:left "" :right ""}}})

(bufferline.setup {:options {:style_preset bufferline.style_preset.no_italic}})
