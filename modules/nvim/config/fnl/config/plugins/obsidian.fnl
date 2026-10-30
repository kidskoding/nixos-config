(vim.pack.add [{:src "https://github.com/obsidian-nvim/obsidian.nvim"
                :version (vim.version.range "*")}])

(local obsidian (require :obsidian))

;; obsidian.nvim errors at startup when no workspace path exists, so only
;; keep vaults present on this machine and skip setup when there are none.
(local workspaces (icollect [_ ws (ipairs [{:name :vault
                                            :path "~/Obsidian Vault"}])]
                    (when (= 1 (vim.fn.isdirectory (vim.fn.expand ws.path)))
                      ws)))

(fn map [key cmd desc]
  (vim.keymap.set :n key (.. :<cmd> cmd :<CR>) {: desc}))

(when (> (length workspaces) 0)
  (obsidian.setup {:legacy_commands false
                   : workspaces
                   :picker {:name :snacks.picker}
                   :ui {:enable false}
                   :frontmatter {:enabled false}})
  (map :<leader>of "Obsidian quick_switch" "Find note")
  (map :<leader>os "Obsidian search" "Search notes")
  (map :<leader>on "Obsidian new" "New note")
  (map :<leader>od "Obsidian today" "Daily note")
  (map :<leader>ob "Obsidian backlinks" :Backlinks)
  (map :<leader>ot "Obsidian tags" "Search tags"))
