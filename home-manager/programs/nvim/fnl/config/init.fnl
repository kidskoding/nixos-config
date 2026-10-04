(require :config.options)
(require :config.colorscheme)
(require :config.ui)
(require :config.lsp)
(require :config.editor)
(require :config.snacks)
(require :config.treesitter)
(require :config.completion)
(require :config.format)
(require :config.whichkey)
(require :config.languages)
(require :config.database)
(require :config.ai)

;; neovide
(when vim.g.neovide
  (set vim.g.neovide_animation_length 0)
  (set vim.g.neovide_cursor_animation_length 0)
  (set vim.g.neovide_cursor_trail_size 0)
  (set vim.g.neovide_cursor_vfx_mode "")
  ;; set font and size!
  (set vim.o.guifont "Terminess Nerd Font Mono:h16"))
