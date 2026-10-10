(vim.pack.add [{:src "https://codeberg.org/evergarden/nvim" :name :evergarden}])

(local evergarden (require :evergarden))

(evergarden.setup {:theme {:variant :fall :accent :green}
                   :style {:types []
                           :keyword []
                           :comment []
                           :search [:reverse]
                           :incsearch [:reverse]}
                   :overrides {"@punctuation.bracket" {:link :Normal}
                               "@punctuation.delimiter" {:link :Normal}
                               :SnacksPickerDelim {:link :SnacksPickerRow}
                               :SnacksPickerCol {:link :SnacksPickerRow}
                               :TroubleNormal {:link :Normal}
                               :TroubleNormalNC {:link :Normal}
                               :Added {:fg "#CBE3B3"}
                               :Removed {:fg "#F57F82"}
                               :Changed {:fg "#F5D098"}
                               :GitSignsChange {:fg "#F5D098"}
                               :GitSignsUntracked {:fg "#B3E3CA"}}})

(vim.cmd.colorscheme :evergarden)
