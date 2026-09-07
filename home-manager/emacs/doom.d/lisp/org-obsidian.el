;;; org-obsidian.el -- org notes in an Obsidian vault: markdown mirrors, and a client

;; Obsidian only indexes .md, so a notes tree that wants a graph keeps generated
;; mirrors beside its .org files. A tree opts in by putting an executable
;; obsidian-sync.sh at its root; saving any org file at or under it re-runs that
;; script. Nothing here knows how the conversion works, that is the script's job.
;;
;; `auto-save-visited-mode' writes every 2s, so this debounces on idle rather
;; than syncing per save -- same reason `+org-live-pdf--watch-child' exists.

(defvar +org-obsidian-script "obsidian-sync.sh"
  "Name of the per-tree sync script, looked for at or above the saved file.")

(defvar +org-obsidian-idle 3
  "Seconds of idle time before a save triggers a sync.")

(defvar +org-obsidian--timer nil)

(defun +org-obsidian--run (dir)
  (setq +org-obsidian--timer nil)
  (let ((default-directory dir))
    (start-process "obsidian-sync" "*obsidian-sync*"
                   (expand-file-name +org-obsidian-script dir))))

(defun +org-obsidian--on-save ()
  (when (and buffer-file-name (derived-mode-p 'org-mode))
    (when-let* ((dir (locate-dominating-file buffer-file-name +org-obsidian-script))
                (script (expand-file-name +org-obsidian-script dir))
                ((file-executable-p script)))
      (when +org-obsidian--timer (cancel-timer +org-obsidian--timer))
      (setq +org-obsidian--timer
            (run-with-idle-timer +org-obsidian-idle nil #'+org-obsidian--run dir)))))

(add-hook 'after-save-hook #'+org-obsidian--on-save)

;; --- Emacs client for the vault ---
;; Navigation only, deliberately. Every .md in the vault is generated from an
;; .org, so anything typed into one is gone at the next save; capture and link
;; insertion are left unbound for that reason. Editing stays in org.
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
