(vim.pack.add ["https://github.com/ellisonleao/gruvbox.nvim"])

(local gruvbox (require :gruvbox))

(gruvbox.setup {:italic {:strings false
                         :emphasis false
                         :comments false
                         :operators false
                         :folds false}
                :overrides {"@punctuation.bracket" {:link :Normal}
                            "@punctuation.delimiter" {:link :Normal}
                            :TroubleNormal {:link :Normal}
                            :TroubleNormalNC {:link :Normal}
                            :Added {:link :GruvboxGreen}
                            :Removed {:link :GruvboxRed}
                            :Changed {:link :GruvboxYellow}
                            :GitSignsChange {:link :GruvboxYellow}
                            :GitSignsUntracked {:link :GruvboxAqua}}})

(vim.cmd.colorscheme :gruvbox)
