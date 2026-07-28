;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Anirudh Konidala"
      user-mail-address "anirudhkonidala@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'kanagawa-wave)
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
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

;; use fish as Emacs' internal shell (ghostel, shell-command, etc.)
(setq explicit-shell-file-name "/run/current-system/sw/bin/fish")

(after! ghostel
  (setq ghostel-module-auto-install 'download))

;; quit without a confirmation prompt
(setq confirm-kill-emacs nil)

;; use the system (Wayland) clipboard instead of Emacs' own kill ring
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

;; snappier LSP diagnostics/completion, at the cost of more CPU while typing
(after! lsp-mode
  (setq lsp-idle-delay 0.1)
  (setq lsp-auto-guess-root t))
(after! flycheck
  (setq flycheck-idle-change-delay 0.1))

;; write the real file after 2s idle, so checkers that read from disk
;; (LSP servers, external linters) report errors without an explicit C-x C-s
(setq auto-save-visited-interval 2)
(auto-save-visited-mode +1)

(use-package! agent-shell
  :commands (agent-shell
             agent-shell-anthropic-start-claude-code
             agent-shell-openai-start-codex)
  :config
  (setq agent-shell-anthropic-authentication
        (agent-shell-anthropic-make-authentication :login t))
  ;; the agent process otherwise spawns with a bare environment and loses PATH
  (setq agent-shell-anthropic-claude-environment
        (agent-shell-make-environment-variables :inherit-env t))
  (setq agent-shell-openai-codex-environment
        (agent-shell-make-environment-variables :inherit-env t)))

;; corfu's popup needs child frames, which don't exist in terminal Emacs;
;; corfu-terminal renders it with overlays instead so completion shows up in -nw
(unless (display-graphic-p)
  (after! corfu
    (corfu-terminal-mode +1)))
