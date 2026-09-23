(vim.pack.add ["https://github.com/stevearc/conform.nvim"])

(local conform (require :conform))

(conform.setup {:formatters_by_ft {:fennel [:fnlfmt]
                                   :lua [:stylua]
                                   :nix [:alejandra]
                                   :python [:ruff_format]
                                   :typst [:typstyle]}})

(vim.keymap.set :n :<leader>cf #(conform.format {:lsp_format :fallback})
                {:desc "Format buffer"})
