(vim.pack.add ["https://github.com/ellisonleao/gruvbox.nvim"])

(local gruvbox (require :gruvbox))

(gruvbox.setup {:italic {:strings false
                         :emphasis false
                         :comments false
                         :operators false
                         :folds false}
                :overrides {"@punctuation.bracket" {:link :Normal}
                            "@punctuation.delimiter" {:link :Normal}}})

(vim.cmd.colorscheme :gruvbox)
