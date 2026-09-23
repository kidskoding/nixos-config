(vim.pack.add [{:src "https://github.com/nvim-treesitter/nvim-treesitter"
                :version :main}])

(local treesitter (require :nvim-treesitter))

;; installs only missing parsers, in the background
(treesitter.install [:bash
                     :css
                     :fennel
                     :fish
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

;; highlight and indent with treesitter when a parser exists for the filetype
(vim.api.nvim_create_autocmd :FileType
                             {:callback #(when (pcall vim.treesitter.start)
                                           (set vim.bo.indentexpr
                                                "v:lua.require'nvim-treesitter'.indentexpr()"))})
