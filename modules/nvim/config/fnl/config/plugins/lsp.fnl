(vim.pack.add ["https://github.com/neovim/nvim-lspconfig"
               "https://github.com/folke/trouble.nvim"])

(vim.lsp.config :lua_ls {:settings {:Lua {:diagnostics {:globals [:vim]}}}})

(vim.lsp.config :ruff {:init_options {:settings {:showSyntaxErrors false
                                                 :lint {:ignore [:F821 :F841]}}}
                       :on_attach (fn [client _]
                                    (set client.server_capabilities.diagnosticProvider
                                         false)
                                    (set client.server_capabilities.hoverProvider
                                         false))})

(vim.lsp.config :tinymist
                {:settings {:exportPdf :onType
                            :formatterMode :typstyle
                            :lint {:enabled true :when :onSave}}})

(vim.lsp.config :mdx_analyzer
                {:cmd [:mdx-language-server :--stdio]
                 :filetypes [:mdx]
                 :init_options {:typescript {:tsdk vim.env.TSDK}}})

(vim.lsp.config :marksman {:filetypes [:markdown :mdx]})

(vim.lsp.config :sourcekit {:filetypes [:swift]})

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
                 :mdx_analyzer
                 :nixd
                 :ocamllsp
                 :omnisharp
                 :ruby_lsp
                 :ruff
                 :sourcekit
                 :sqls
                 :taplo
                 :terraformls
                 :tinymist
                 :tsc
                 :ty
                 :yamlls
                 :zls])

(local trouble (require :trouble))
(trouble.setup {:modes {:diagnostics {:auto_close true}}})

(fn map [key cmd desc]
  (vim.keymap.set :n key (.. "<cmd>Trouble " cmd :<CR>) {: desc}))

(map :<leader>cd "diagnostics toggle filter.buf=0" "Buffer diagnostics")
(map :<leader>cs "symbols toggle focus=false" :Symbols)
(map :<leader>cl "lsp toggle focus=false win.position=right"
     "LSP definitions / references")

(map :<leader>xq "qflist toggle" "Quickfix list")
(map :<leader>xl "loclist toggle" "Location list")

;; snacks loads later; resolve picker at keypress time
(vim.keymap.set :n :gd #((. (require :snacks) :picker :lsp_definitions))
                {:desc "Go to definition"})

(vim.keymap.set :n :grr #((. (require :snacks) :picker :lsp_references))
                {:desc :References})
