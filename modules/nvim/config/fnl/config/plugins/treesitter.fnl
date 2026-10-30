(vim.pack.add [{:src "https://github.com/nvim-treesitter/nvim-treesitter"
                :version :main}
               "https://github.com/nvim-treesitter/nvim-treesitter-context"])

(local treesitter (require :nvim-treesitter))
(local treesitter-context (require :treesitter-context))

;; installs only missing parsers, in the background
(treesitter.install [:bash
                     :css
                     :fennel
                     :fish
                     :go
                     :html
                     :javascript
                     :json
                     :nix
                     :python
                     :rust
                     :scss
                     :svelte
                     :toml
                     :tsx
                     :typescript
                     :typst
                     :vue
                     :yaml])

(treesitter-context.setup {:max_lines 3 :separator nil})

(let [ts vim.treesitter.language]
  (ts.register :markdown :mdx))

;; highlight and indent with treesitter when a parser exists for the filetype
(vim.api.nvim_create_autocmd :FileType
                             {:callback #(when (pcall vim.treesitter.start)
                                           (set vim.bo.indentexpr
                                                "v:lua.require'nvim-treesitter'.indentexpr()"))})
