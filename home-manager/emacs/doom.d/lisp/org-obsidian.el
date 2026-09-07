;;; org-obsidian.el -- keep a notes tree's Obsidian markdown in step with org

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
