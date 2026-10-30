(vim.pack.add ["https://github.com/ellisonleao/gruvbox.nvim"])

(local gruvbox (require :gruvbox))

(gruvbox.setup {:italic {:strings false
                         :emphasis false
                         :comments false
                         :operators false
                         :folds false}
                :overrides {;; treesitter: brackets and delimiters in plain fg
                            "@punctuation.bracket" {:link :Normal}
                            "@punctuation.delimiter" {:link :Normal}
                            ;; trouble: match editor background
                            :TroubleNormal {:link :Normal}
                            :TroubleNormalNC {:link :Normal}
                            ;; diff colors
                            :Added {:link :GruvboxGreen}
                            :Removed {:link :GruvboxRed}
                            :Changed {:link :GruvboxYellow}
                            ;; gitsigns: change in yellow, untracked in aqua
                            :GitSignsChange {:link :GruvboxYellow}
                            :GitSignsUntracked {:link :GruvboxAqua}
                            ;; sign column and signs on editor bg, not bg1
                            :SignColumn {:link :Normal}
                            :GruvboxRedSign {:link :GruvboxRed}
                            :GruvboxGreenSign {:link :GruvboxGreen}
                            :GruvboxYellowSign {:link :GruvboxYellow}
                            :GruvboxBlueSign {:link :GruvboxBlue}
                            :GruvboxPurpleSign {:link :GruvboxPurple}
                            :GruvboxAquaSign {:link :GruvboxAqua}
                            :GruvboxOrangeSign {:link :GruvboxOrange}
                            ;; snacks dashboard menu: neutral so ferris stands out
                            :SnacksDashboardIcon {:link :GruvboxBlue}
                            :SnacksDashboardDesc {:link :GruvboxBlue}
                            :SnacksDashboardKey {:link :GruvboxFg1}
                            :SnacksDashboardDir {:link :GruvboxGray}
                            :SnacksDashboardTitle {:link :GruvboxGray}
                            ;; snacks picker title toggles as badges
                            :SnacksPickerToggle {:fg gruvbox.palette.bright_blue
                                                 :bg gruvbox.palette.dark2
                                                 :bold true}}})

(vim.cmd.colorscheme :gruvbox)
