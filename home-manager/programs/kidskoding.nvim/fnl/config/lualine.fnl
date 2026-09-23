(vim.pack.add ["https://github.com/nvim-lualine/lualine.nvim"
               "https://github.com/nvim-tree/nvim-web-devicons"])

;; colors for the │ component separators below
(vim.api.nvim_set_hl 0 :lualine_sep_color_b {:fg "#a89984" :bg "#504945"})
(vim.api.nvim_set_hl 0 :lualine_sep_color_x {:fg "#a89984" :bg "#3c3836"})

;; patched gruvbox_dark
;; normal mode: yellow instead of gruvbox grey!
;; every other mode shares normal mode's section c colors
(local theme (require :lualine.themes.gruvbox_dark))
(each [_ section (pairs theme)]
  (set section.c theme.normal.c))
(set theme.normal.a.bg "#d79921")

(local lualine (require :lualine))
(lualine.setup {:options {:theme theme
                          :component_separators {:left "%#lualine_sep_color_b#│"
                                                 :right "%#lualine_sep_color_x#│"}
                          :section_separators {:left "" :right ""}}})
