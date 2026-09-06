;;; ui.el -- frame furniture: file manager, presence, window movement

(after! dirvish
  (custom-set-faces!
    '(dirvish-hl-line :inherit region :extend t)))

(custom-set-faces!
  '(mode-line :background "#3c3836")
  '(mode-line-inactive :background "#282828"))

(add-hook! 'dired-mode-hook
  (defun +dired-dark-bg-h ()
    (face-remap-add-relative 'default :background "#1d2021")))

(use-package! elcord
  :config
  (elcord-mode))

(windmove-default-keybindings)
