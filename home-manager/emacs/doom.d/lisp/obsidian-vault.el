;;; obsidian-vault.el -- Emacs client for the Obsidian markdown vault

;; `obsidian.el' indexes a directory of .md as a vault: jump between notes,
;; follow [[wikilinks]], list backlinks, search, tags. It is markdown-only, so
;; org notes are invisible to it; org is edited through `org-mode' as usual and
;; rendered inside the Obsidian app by the orgmode-cm6 plugin. No conversion.
;;
;; Loads with markdown-mode, i.e. the first time a note is opened, never at
;; startup. `obsidian-backlinks-mode' is left off: it steals a side window in
;; every note buffer. M-x it when you want the panel.
(use-package! obsidian
  :after markdown-mode
  :custom
  (obsidian-directory "~/notes")
  (markdown-enable-wiki-links t)
  :config
  (global-obsidian-mode +1)
  :bind (:map obsidian-mode-map
         ("C-c C-o" . obsidian-follow-link-at-point)
         ("C-c C-p" . obsidian-jump)
         ("C-c C-b" . obsidian-backlink-jump)))
