(set vim.g.rustaceanvim
     {:server {:default_settings {:rust-analyzer {:cargo {:allFeatures true}
                                                  :check {:command :clippy}}}}})

(vim.pack.add ["https://github.com/mrcjkb/rustaceanvim"
               "https://github.com/saecki/crates.nvim"])

(local crates (require :crates))

(crates.setup {:lsp {:enabled true :actions true :completion true :hover true}
               :completion {:crates {:enabled true :max_results 8 :min_chars 3}}})

(fn map [key action desc]
  (vim.keymap.set :n key action {: desc}))

(map :<leader>ra "<cmd>RustLsp codeAction<CR>" "Rust code action")
(map :<leader>rr "<cmd>RustLsp runnables<CR>" "Rust runnables")
(map :<leader>rt "<cmd>RustLsp testables<CR>" "Rust testables")
(map :<leader>re "<cmd>RustLsp explainError<CR>" "Explain Rust error")
