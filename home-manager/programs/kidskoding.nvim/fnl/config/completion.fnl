(vim.pack.add [{:src "https://github.com/saghen/blink.cmp"
                :version (vim.version.range :1.*)}
               "https://github.com/rafamadriz/friendly-snippets"])

(local blink (require :blink.cmp))

(blink.setup {:keymap {:preset :none
                       :<C-n> [:insert_next :fallback]
                       :<C-p> [:insert_prev :fallback]
                       :<Down> [:select_next :fallback]
                       :<Up> [:select_prev :fallback]
                       :<C-y> [:accept :fallback]
                       :<Tab> [:accept :fallback]
                       :<C-e> [:cancel :fallback]}})
