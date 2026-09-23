(vim.lsp.config :fennel_ls
                {:cmd [:fennel-ls]
                 :filetypes [:fennel]
                 :root_markers [:flsproject.fnl :.git]})

(vim.lsp.enable :fennel_ls)

(vim.api.nvim_create_autocmd :FileType
                             {:pattern :fennel
                              :callback #(set vim.bo.formatprg "fnlfmt -")})
