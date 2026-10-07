(vim.pack.add ["https://github.com/neanias/everforest-nvim"])

(local everforest (require :everforest))

(everforest.setup {:background :hard
                   :disable_italic_comments true
                   :on_highlights (fn [hl _palette]
                                    (set hl.TroubleNormal {:link :Normal})
                                    (set hl.TroubleNormalNC {:link :Normal})
                                    (set hl.Added {:link :Green})
                                    (set hl.Removed {:link :Red})
                                    (set hl.Changed {:link :Yellow})
                                    (set hl.GitSignsChange {:link :Yellow})
                                    (set hl.GitSignsUntracked {:link :Aqua})
                                    (tset hl "@punctuation.bracket"
                                          {:link :Normal})
                                    (tset hl "@punctuation.delimiter"
                                          {:link :Normal}))})

(vim.cmd.colorscheme :everforest)
