(set vim.g.mapleader " ")

(set vim.o.clipboard :unnamedplus)
(set vim.o.number true)

;; 4-space indent!
(set vim.o.expandtab true)
(set vim.o.shiftwidth 4)
(set vim.o.softtabstop 4)
(set vim.o.tabstop 4)

;; show diagnostics as lines under the cursor's line only
(vim.diagnostic.config {:virtual_lines {:current_line true}})

