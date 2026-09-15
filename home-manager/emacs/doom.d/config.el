(setq user-full-name "Anirudh Konidala"
      user-mail-address "anirudhkonidala@gmail.com")

(setq doom-theme 'gruvbox-dark-medium)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")
(setq shell-file-name (executable-find "bash"))

(setq-default vterm-shell "/run/current-system/sw/bin/fish")
(setq-default explicit-shell-file-name "/run/current-system/sw/bin/fish")

(load! "lisp/ui")
(load! "lisp/completion")
(load! "lisp/editor")
(load! "lisp/org")
(load! "lisp/agenda")
(load! "lisp/org-live-pdf")
(load! "lisp/obsidian-vault")
