;;; ui.el -- frame furniture: file manager, presence, window movement

(after! dirvish
  (setq dirvish-attributes nil)
  (custom-set-faces!
    '(dirvish-hl-line :inherit region :extend t)))

(custom-set-faces!
  '(mode-line :background "#3c3836")
  '(mode-line-inactive :background "#282828")
  '(line-number :background "#3c3836")
  '(centaur-tabs-default :background "#1d2021")
  '(centaur-tabs-unselected :background "#1d2021" :foreground "#928374")
  '(centaur-tabs-selected :background "#3c3836" :foreground "#ebdbb2")
  '(centaur-tabs-selected-modified :inherit centaur-tabs-selected)
  '(centaur-tabs-unselected-modified :inherit centaur-tabs-unselected))

(setq diff-hl-side 'right)
(setq diff-hl-margin-symbols-alist
      '((insert . "▌") (delete . "▌") (change . "▌") (unknown . "▌") (ignored . "▌") (reference . " ")))

(add-hook! 'dired-mode-hook
  (defun +dired-dark-bg-h ()
    (face-remap-add-relative 'default :background "#0d1011")))

;; elcord polls; it installs no buffer-switch hook, so the refresh rate is how
;; long Discord keeps showing the file you just left. Discord rate-limits
;; SET_ACTIVITY to 5 per 20s and elcord answers a rejected update by
;; disconnecting and reconnecting, so do not push this below ~4.
(use-package! elcord
  :custom
  (elcord-refresh-rate 5)
  (elcord-editor-icon "doom_icon")
  :init
  (defvar doom-version (doom-version))
  :config
  (elcord-mode))

(windmove-default-keybindings)
