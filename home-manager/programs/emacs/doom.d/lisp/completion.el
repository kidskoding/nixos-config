;;; completion.el -- minibuffer: affe, vertico, marginalia

(use-package! affe
  :commands (affe-find affe-grep)
  :config
  (consult-customize affe-find affe-grep :preview-key "M-.")
  (setq affe-find-command "fd --hidden --type f --exclude .git")

  (defun +affe-orderless-regexp-compiler (input _type _ignorecase)
    (setq input (cdr (orderless-compile input)))
    (cons input (apply-partially #'orderless--highlight input t)))
  (setq affe-regexp-compiler #'+affe-orderless-regexp-compiler))

(defun +affe-find-project ()
  "Fuzzy-find a file in the current project."
  (interactive)
  (affe-find (or (doom-project-root) default-directory)))

(defun +affe-grep-project ()
  "Fuzzy-grep the contents of the current project."
  (interactive)
  (affe-grep (or (doom-project-root) default-directory)))

(map! "M-d" #'+affe-find-project
      :leader
      "/" #'+affe-grep-project
      "j" #'dired-jump)

(after! vertico
  (map! :map vertico-map "M-d" #'abort-minibuffers)
  (vertico-multiform-mode +1)
  (defun +vertico-buffer-graphic (arg)
    (if (> arg 0)
        (when (display-graphic-p) (vertico-buffer-mode 1))
      (vertico-buffer-mode -1)))
  (setq vertico-multiform-commands
        '((consult-buffer +vertico-buffer-graphic)
          (consult-line +vertico-buffer-graphic)
          (+affe-find-project +vertico-buffer-graphic)
          (+affe-grep-project +vertico-buffer-graphic)))
  (setq vertico-buffer-display-action
        '(display-buffer-in-side-window
          (side . bottom)
          (window-height . 0.4)
          (window-parameters . ((mode-line-format . none))))))

(use-package! nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))
