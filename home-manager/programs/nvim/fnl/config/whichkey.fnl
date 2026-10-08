(vim.pack.add ["https://github.com/folke/which-key.nvim"])

(local which-key (require :which-key))

;; leader group names. groups with no keymaps yet stay hidden
(which-key.setup {:spec [{1 :<leader>a :group :ai}
                         {1 :<leader>b :group :buffers}
                         {1 :<leader>c :group :code}
                         {1 :<leader>D :group :database :icon " "}
                         {1 :<leader>g :group :git}
                         {1 :<leader>m :group :markdown :icon " "}
                         {1 :<leader>o :group :obsidian :icon "󰠮 "}
                         {1 :<leader>r
                          :group :rust
                          :icon {:icon " " :color :orange}}
                         {1 :<leader>t :group :test :icon "󰙨 "}
                         {1 :<leader>T :group :typst :icon "󰈙 "}
                         {1 :<leader>x :group :lists :icon " "}]})

(vim.api.nvim_set_hl 0 :WhichKeyIcon {:fg "#B2CAED"})
