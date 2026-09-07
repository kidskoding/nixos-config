;;; ui.el -- frame furniture: file manager, presence, window movement

(after! dirvish
  (setq dirvish-attributes nil)
  (custom-set-faces!
    '(dirvish-hl-line :inherit region :extend t)))

;; elcord polls; it installs no buffer-switch hook, so the refresh rate is how
;; long Discord keeps showing the file you just left. Discord rate-limits
;; SET_ACTIVITY to 5 per 20s and elcord answers a rejected update by
;; disconnecting and reconnecting, so do not push this below ~4.
(use-package! elcord
  :custom
  (elcord-refresh-rate 5)
  :config
  (elcord-mode))

(windmove-default-keybindings)
