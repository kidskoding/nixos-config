;;; editor.el -- shell, clipboard, lsp, saving, per-mode editing

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
  (setq lsp-enable-suggest-server-download nil)
  (setq lsp-lens-enable nil))
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
