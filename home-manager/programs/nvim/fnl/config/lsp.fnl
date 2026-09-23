(vim.pack.add ["https://github.com/neovim/nvim-lspconfig"
               "https://github.com/folke/trouble.nvim"])

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

(local trouble (require :trouble))
(trouble.setup {})

(fn map [key cmd desc]
  (vim.keymap.set :n key (.. "<cmd>Trouble " cmd :<CR>) {: desc}))

(map :<leader>cd "diagnostics toggle filter.buf=0" "Buffer diagnostics")
(map :<leader>cs "symbols toggle focus=false" :Symbols)
(map :<leader>cl "lsp toggle focus=false win.position=right"
     "LSP definitions / references")

(map :<leader>xq "qflist toggle" "Quickfix list")
(map :<leader>xl "loclist toggle" "Location list")
