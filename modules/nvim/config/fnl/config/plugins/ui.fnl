(vim.pack.add ["https://github.com/nvim-lualine/lualine.nvim"
               "https://github.com/nvim-tree/nvim-web-devicons"
               "https://github.com/akinsho/bufferline.nvim"
               "https://github.com/brenoprata10/nvim-highlight-colors"
               "https://github.com/folke/which-key.nvim"])

(local lualine (require :lualine))
(local bufferline (require :bufferline))
(local highlight-colors (require :nvim-highlight-colors))
(local which-key (require :which-key))

(highlight-colors.setup {:render :background :enable_tailwind true})

(vim.api.nvim_set_hl 0 :lualine_sep_color_b {:fg "#a89984" :bg "#504945"})
(vim.api.nvim_set_hl 0 :lualine_sep_color_x {:fg "#a89984" :bg "#3c3836"})

(local theme (require :lualine.themes.gruvbox_dark))
(each [_ section (pairs theme)]
  (set section.c theme.normal.c))

(set theme.normal.a.bg "#d79921")
;; brighter middle text; the theme's muted gray is hard to read on the bar
(set theme.normal.c.fg "#d5c4a1")
(set theme.terminal {:a {:bg "#d3869b" :fg "#282828" :gui :bold}
                     :b theme.normal.b
                     :c theme.normal.c})

(lualine.setup {:options {: theme
                          :globalstatus true
                          :ignore_focus [:snacks_picker_list
                                         :snacks_picker_input
                                         :snacks_terminal]
                          :component_separators {:left "%#lualine_sep_color_b#│"
                                                 :right "%#lualine_sep_color_x#│"}
                          :section_separators {:left "" :right ""}}
                :sections {:lualine_b [{1 :branch :separator ""} :diff]
                           :lualine_c [{1 :filename :path 1}]
                           :lualine_x [:lsp_status
                                       {1 :diagnostics
                                        :sections [:error :warn]}
                                       :filetype]
                           :lualine_y [:selectioncount]}})

(local normal-bg (. (vim.api.nvim_get_hl 0 {:name :Normal :link false}) :bg))

(local active-bg "#3c3836")

(local buffer-highlights
       {:fill {:bg normal-bg}
        :separator {:fg "#504945" :bg normal-bg}
        :separator_visible {:fg "#504945" :bg normal-bg}
        :separator_selected {:fg "#504945" :bg normal-bg}
        :offset_separator {:bg normal-bg}})

;; every piece of the active tab sits on the same raised background
(each [_ part (ipairs [:indicator
                       :close_button
                       :modified
                       :duplicate
                       :numbers
                       :pick
                       :diagnostic])]
  (tset buffer-highlights (.. part :_selected) {:bg active-bg}))

(each [_ level (ipairs [:hint :info :warning :error])]
  (tset buffer-highlights (.. level :_selected) {:bg active-bg})
  (tset buffer-highlights (.. level :_diagnostic_selected) {:bg active-bg}))

(tset buffer-highlights :buffer_selected
      {:fg "#ebdbb2" :bg active-bg :bold true})

(bufferline.setup {:options {:style_preset [bufferline.style_preset.minimal
                                            bufferline.style_preset.no_italic]
                             :tab_size 0
                             :indicator {:style :none}
                             :separator_style :thin
                             :offsets [{:filetype :snacks_layout_box
                                        :separator true
                                        :highlight :Normal}]}
                   :highlights buffer-highlights})

;; leader group names. groups with no keymaps yet stay hidden
(which-key.setup {:icons {:rules [{:pattern :claude
                                   :icon "󱚣 "
                                   :color :orange}
                                  {:pattern :agent :icon " " :color :purple}]}
                  :spec [{1 :<leader>a
                          :group :ai
                          :icon {:icon "󱚣 " :color :orange}}
                         {1 :<leader>b :group :buffers :icon "󰓩 "}
                         {1 :<leader>c :group :code :icon " "}
                         {1 :<leader>D :group :database :icon " "}
                         {1 :<leader>g :group :git :icon "󰊢 "}
                         {1 :<leader>m :group :markdown :icon " "}
                         {1 :<leader>o :group :obsidian :icon "󰠮 "}
                         {1 :<leader>r
                          :group :rust
                          :icon {:icon " " :color :orange}}
                         {1 :<leader>t :group :test :icon "󰙨 "}
                         {1 :<leader>T :group :typst :icon "󰈙 "}
                         {1 :<leader>x :group :lists :icon " "}]})

(vim.api.nvim_set_hl 0 :WhichKeyIcon {:fg "#B2CAED"})
