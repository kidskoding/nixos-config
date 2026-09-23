(vim.pack.add [{:src "https://github.com/saghen/blink.cmp"
                :version (vim.version.range :1.*)}
               "https://github.com/rafamadriz/friendly-snippets"])

(local blink (require :blink.cmp))

;; sql buffers complete tables and columns from dadbod (database.fnl)
(local sql-sources [:dadbod :snippets :buffer])

(blink.setup {:sources {:per_filetype {:sql sql-sources
                                       :mysql sql-sources
                                       :plsql sql-sources}
                        :providers {:dadbod {:name :Dadbod
                                             :module :vim_dadbod_completion.blink}}}
              :keymap {:preset :none
                       :<C-n> [:insert_next :fallback]
                       :<C-p> [:insert_prev :fallback]
                       :<Down> [:select_next :fallback]
                       :<Up> [:select_prev :fallback]
                       :<C-y> [:accept :fallback]
                       :<Tab> [:accept :fallback]
                       :<C-e> [:cancel :fallback]
                       :<C-space> [:show
                                   :show_documentation
                                   :hide_documentation]}})
