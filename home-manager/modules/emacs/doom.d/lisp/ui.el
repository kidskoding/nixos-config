;;; ui.el -- frame furniture: file manager, presence, window movement

(after! dirvish
  (custom-set-faces!
    '(dirvish-hl-line :inherit region :extend t)))

(use-package! elcord
  :config
  (elcord-mode))

(windmove-default-keybindings)
