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
              :completion {:documentation {:auto_show true
                                           :auto_show_delay_ms 200}}
              :signature {:enabled true}
              :keymap {:preset :none
                       :<C-j> [:insert_next :fallback]
                       :<C-k> [:insert_prev :fallback]
                       :<C-y> [:accept :fallback]
                       :<Tab> [:accept :snippet_forward :fallback]
                       :<S-Tab> [:snippet_backward :fallback]
                       :<CR> [:accept :fallback]
                       :<C-e> [:cancel :fallback]
                       :<C-f> [:scroll_documentation_down :fallback]
                       :<C-b> [:scroll_documentation_up :fallback]
                       :<C-l> [:show_signature :hide_signature :fallback]
                       :<C-space> [:show
                                   :show_documentation
                                   :hide_documentation]}})
