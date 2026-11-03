(local treesitter-context (require :treesitter-context))

(treesitter-context.setup {:max_lines 3 :separator nil})

(let [ts vim.treesitter.language]
  (ts.register :markdown :mdx))

;; highlight and indent with treesitter when a parser exists for the filetype
(vim.api.nvim_create_autocmd :FileType
                             {:callback #(when (pcall vim.treesitter.start)
                                           (set vim.bo.indentexpr
                                                "v:lua.require'nvim-treesitter'.indentexpr()"))})
