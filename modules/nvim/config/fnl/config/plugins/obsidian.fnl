(vim.pack.add [{:src "https://github.com/obsidian-nvim/obsidian.nvim"
                :version (vim.version.range "*")}])

(local obsidian (require :obsidian))

(obsidian.setup {:legacy_commands false
                 :workspaces [{:name :vault :path "~/Obsidian Vault"}]
                 :picker {:name :snacks.picker}
                 :ui {:enable false}
                 :frontmatter {:enabled false}})

(fn map [key cmd desc]
  (vim.keymap.set :n key (.. :<cmd> cmd :<CR>) {: desc}))

(map :<leader>of "Obsidian quick_switch" "Find note")
(map :<leader>os "Obsidian search" "Search notes")
(map :<leader>on "Obsidian new" "New note")
(map :<leader>od "Obsidian today" "Daily note")
(map :<leader>ob "Obsidian backlinks" :Backlinks)
(map :<leader>ot "Obsidian tags" "Search tags")
