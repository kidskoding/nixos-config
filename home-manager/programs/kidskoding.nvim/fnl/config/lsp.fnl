(vim.pack.add ["https://github.com/neovim/nvim-lspconfig"])

(vim.lsp.config :lua_ls {:settings {:Lua {:diagnostics {:globals [:vim]}}}})

(vim.lsp.config :tinymist
                {:settings {:exportPdf :onType
                            :formatterMode :typstyle
                            :lint {:enabled true :when :onSave}}})

;; rust_analyzer is handled by rustaceanvim
(vim.lsp.enable [:clangd
                 :cssls
                 :dockerls
                 :elmls
                 :eslint
                 :fennel_ls
                 :fish_lsp
                 :gopls
                 :graphql
                 :html
                 :intelephense
                 :jdtls
                 :jsonls
                 :julials
                 :kotlin_language_server
                 :lua_ls
                 :marksman
                 :metals
                 :nixd
                 :ocamllsp
                 :omnisharp
                 :ruby_lsp
                 :sourcekit
                 :sqls
                 :taplo
                 :terraformls
                 :tinymist
                 :ts_ls
                 :ty
                 :yamlls
                 :zls])

(vim.api.nvim_create_autocmd :FileType
                             {:pattern :fennel
                              :callback #(set vim.bo.formatprg "fnlfmt -")})
