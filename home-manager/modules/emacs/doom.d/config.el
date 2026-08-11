(setq user-full-name "Anirudh Konidala"
      user-mail-address "anirudhkonidala@gmail.com")

(setq doom-theme 'doom-gruvbox)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq explicit-shell-file-name "/run/current-system/sw/bin/fish")

(after! ghostel
  (setq ghostel-module-auto-install 'download))

(setq confirm-kill-emacs nil)

(when (string-equal (getenv "XDG_SESSION_TYPE") "wayland")
  (defun +wl-copy (text)
    (let ((proc (make-process :name "wl-copy" :buffer nil
                               :command '("wl-copy") :connection-type 'pipe)))
      (process-send-string proc text)
      (process-send-eof proc)))
  (defun +wl-paste ()
    (shell-command-to-string "wl-paste --no-newline"))
  (setq interprogram-cut-function #'+wl-copy)
  (setq interprogram-paste-function #'+wl-paste))

(after! lsp-mode
  (setq lsp-idle-delay 0.1)
  (setq lsp-auto-guess-root t)
  (setq lsp-enable-suggest-server-download nil))
(after! flycheck
  (setq flycheck-idle-change-delay 0.1))

(setq auto-save-visited-interval 2)
(auto-save-visited-mode +1)

(use-package! agent-shell
  :commands (agent-shell
             agent-shell-anthropic-start-claude-code
             agent-shell-openai-start-codex)
  :config
  (setq agent-shell-anthropic-authentication
        (agent-shell-anthropic-make-authentication :login t))
  (setq agent-shell-anthropic-claude-environment
        (agent-shell-make-environment-variables :inherit-env t))
  (setq agent-shell-openai-codex-environment
        (agent-shell-make-environment-variables :inherit-env t)))

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

(map! "M-d" #'+affe-find-project)

(map! :leader
      :desc "Find file in project" "SPC" #'+affe-find-project
      :desc "Search project"       "/"   #'+affe-grep-project)

(after! vertico
  (vertico-multiform-mode +1)
  (setq vertico-multiform-commands
        '((consult-buffer buffer)
          (consult-line buffer)
          (+affe-find-project buffer)
          (+affe-grep-project buffer)))
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

(after! marginalia
  (custom-set-faces!
    `(marginalia-size :foreground ,(doom-color 'yellow))
    `(marginalia-number :foreground ,(doom-color 'yellow))
    `(marginalia-date :foreground ,(doom-color 'blue))
    `(marginalia-file-priv-dir :foreground ,(doom-color 'blue))
    `(marginalia-file-priv-link :foreground ,(doom-color 'cyan))
    `(marginalia-file-priv-exec :foreground ,(doom-color 'grey))
    `(marginalia-file-priv-read :foreground ,(doom-color 'grey))
    `(marginalia-file-priv-write :foreground ,(doom-color 'grey))
    `(marginalia-file-priv-other :foreground ,(doom-color 'grey))
    `(marginalia-file-priv-no :foreground ,(doom-color 'grey))))

(use-package! elcord
  :config
  (elcord-mode))

(windmove-default-keybindings)

(after! pdf-tools
  (setq pdf-info-epdfinfo-program (executable-find "epdfinfo")))

(setq-hook! '(nix-mode-hook nix-ts-mode-hook yaml-mode-hook yaml-ts-mode-hook)
  tab-width 2
  nix-ts-mode-indent-offset 2
  yaml-indent-offset 2)

(after! markdown-mode
  (map! :localleader
        :map markdown-mode-map
        "p" #'markdown-live-preview-mode
        "h" #'markdown-toggle-markup-hiding))
