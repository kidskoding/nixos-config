(setq user-full-name "Anirudh Konidala"
      user-mail-address "anirudhkonidala@gmail.com")

(setq doom-theme 'doom-gruvbox)
(setq display-line-numbers-type t)
(setq org-directory "~/org/")

(after! org
  (setq org-startup-indented t
        org-startup-folded 'content
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-ellipsis " ▾"
        org-cycle-separator-lines 2
        org-image-actual-width '(700))

  (add-hook 'org-mode-hook #'visual-line-mode)

  (custom-set-faces!
    '(org-document-title :height 1.5 :weight bold)
    '(org-level-1 :height 1.30 :weight bold)
    '(org-level-2 :height 1.20 :weight bold)
    '(org-level-3 :height 1.10 :weight semi-bold)
    '(org-level-4 :height 1.05 :weight semi-bold)
    '(org-block :extend t)
    '(org-code :inherit fixed-pitch)
    '(org-table :inherit fixed-pitch)
    '(org-verbatim :inherit fixed-pitch)
    '(org-checkbox :inherit fixed-pitch)))

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star 'replace
        org-modern-hide-stars 'leading
        org-modern-table t
        org-modern-list '((43 . "•")
                          (45 . "–")
                          (42 . "◦"))))

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

(after! dirvish
  (custom-set-faces!
    '(dirvish-hl-line :inherit region :extend t)))

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

;; --- LaTeX math in org notes ---
(after! org
  (setq org-preview-latex-default-process 'dvisvgm
        org-highlight-latex-and-related '(native script entities)
        ;; render fragments on file open. A no-op in tty frames, which cannot
        ;; display images at all -- see the frame note below.
        org-startup-with-latex-preview t)
  (plist-put org-format-latex-options :scale 1.5)
  ;; 'auto takes the colour of the face at point, so a fragment inside a
  ;; heading or a bold run renders a different colour than one in body text.
  ;; 'default pins every fragment to the default face.
  (plist-put org-format-latex-options :foreground 'default)
  ;; No packages added to `org-latex-packages-alist' here. Both export and
  ;; preview build their preamble from the buffer's own #+LATEX_HEADER and
  ;; #+SETUPFILE (see `org-export-get-environment' in `org-create-formula-image'),
  ;; so amsmath and friends belong in the project's setup file, not machine-wide.
  (add-hook 'org-mode-hook #'turn-on-org-cdlatex))

;; render fragment when cursor leaves it, show source when inside.
;; Deliberately NOT gated on display-graphic-p: with a daemon serving both tty
;; and GUI frames, the hook runs once at file-open time, so gating leaves any
;; buffer first opened in a terminal permanently without previews even after you
;; view it in a graphical frame. In a tty the mode just calls a function that
;; returns nil immediately, which is cheaper than that surprise.
(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))

;; --- PDF via zathura ---
(after! org
  (setq org-file-apps
        (append '(("\\.pdf\\'" . "zathura %s")) org-file-apps)))

(after! tex
  (setq TeX-view-program-selection '((output-pdf "Zathura"))))

;; --- live PDF preview from a terminal frame ---
;; Enable `+org-live-pdf-mode' from the master org file, the one with the
;; #+INCLUDE: lines.
;;   master.org             -> master.pdf  (root, live in zathura via latexmk -pvc)
;;   any sibling .org       -> lectures/NAME.pdf, and in the book
;;   generated .tex and aux -> out/
;; That default suits one flat directory of notes. A project with more structure
;; sets `+org-live-pdf-children' in its own .dir-locals.el; nothing about any
;; particular course belongs in this file.
;; Export is pure elisp and fast; latexmk does the slow part out of process, so
;; this works in `emacsclient -nw' where org-latex-preview cannot render at all.
;; ponytail: one master at a time (global singleton). Make the state buffer-local
;; if you ever want two courses live at once.
(defvar +org-live-pdf-out-dir "out"
  "Directory, relative to the master, for generated .tex and aux files.")
(put '+org-live-pdf-out-dir 'safe-local-variable #'stringp)

(defvar +org-live-pdf-children '(("." "lectures" t))
  "How to treat org files under the master's directory.
Each entry is (DIR PDF-DIR IN-BOOK), both dirs relative to the master.
PDF-DIR nil means the file gets no standalone PDF; IN-BOOK non-nil means it
is #+INCLUDEd in the master, so saving it must re-export the master.
Directories not listed here are ignored entirely.

Per-project layout goes in that project's .dir-locals.el, not here. The value
is read once, from the master buffer, when `+org-live-pdf-mode' is enabled.")

;; plain data, no forms to evaluate, so a project's .dir-locals.el can set it
;; without prompting
(put '+org-live-pdf-children 'safe-local-variable #'listp)

(defvar +org-live-pdf-ignore '("setup.org")
  "Org files that are includes or fragments, never sources in their own right.")
(put '+org-live-pdf-ignore 'safe-local-variable #'listp)

(defvar +org-live-pdf--master nil "Absolute path of the master file, while on.")
(defvar +org-live-pdf--children nil
  "Value of `+org-live-pdf-children' as read in the master buffer, while on.
Snapshotted there so .dir-locals.el wins, and so the layout stays consistent
for files that no buffer is visiting.")
(defvar +org-live-pdf--proc nil "The `latexmk -pvc' process watching the master.")

(defun +org-live-pdf--root ()
  "Directory of the master file. All other paths here are relative to it."
  (file-name-directory +org-live-pdf--master))

(defun +org-live-pdf--export (org)
  "Export ORG to `+org-live-pdf-out-dir'/NAME.tex and return that path."
  (with-current-buffer (find-file-noselect org)
    (let ((tex (org-latex-export-to-latex))
          (out (expand-file-name +org-live-pdf-out-dir (+org-live-pdf--root))))
      (make-directory out t)
      (let ((dest (expand-file-name (file-name-nondirectory tex) out)))
        (rename-file tex dest t)
        dest))))

(defun +org-live-pdf--build-child (org pdf-dir)
  "Compile ORG to PDF-DIR/NAME.pdf, aux in the out dir.
PDF-DIR is relative to the master, not to ORG, so latexmk runs from the root."
  (let* ((tex (+org-live-pdf--export org))
         (default-directory (+org-live-pdf--root)))
    (make-directory pdf-dir t)
    (start-process
     "org-child-pdf" "*org-live-pdf*" "latexmk"
     "-pdf" "-interaction=nonstopmode"
     (format "-auxdir=%s" +org-live-pdf-out-dir)
     (format "-outdir=%s" pdf-dir)
     "-e" "$failure_cmd=q(notify-send -u normal -h string:x-canonical-private-synchronous:latexmk 'LaTeX build failed' 'see *org-live-pdf*')"
     tex)))

(defun +org-live-pdf--entry (file)
  "The `+org-live-pdf-children' entry governing FILE, or nil if untracked."
  (let ((file (expand-file-name file)))
    (when (and +org-live-pdf--master
               (equal (file-name-extension file) "org")
               (not (equal file +org-live-pdf--master))
               (not (member (file-name-nondirectory file) +org-live-pdf-ignore)))
      ;; a file outside the tree relativises to "../..." and matches nothing
      (assoc (directory-file-name
              (file-relative-name (file-name-directory file) (+org-live-pdf--root)))
             +org-live-pdf--children))))

(defun +org-live-pdf--on-save ()
  "Refresh the master .tex, and this file's own PDF, when a tracked file is saved."
  (when (and +org-live-pdf--master buffer-file-name)
    (let ((master-p (equal (expand-file-name buffer-file-name) +org-live-pdf--master))
          (entry (+org-live-pdf--entry buffer-file-name)))
      ;; latexmk -pvc notices the rewritten .tex and zathura reloads the PDF
      (when (or master-p (nth 2 entry))
        (+org-live-pdf--export +org-live-pdf--master))
      (when (nth 1 entry)
        (+org-live-pdf--build-child (expand-file-name buffer-file-name) (nth 1 entry))))))

(defun +org-live-pdf-build-all ()
  "Rebuild every standalone child PDF under the master's directory."
  (interactive)
  (unless +org-live-pdf--master
    (user-error "Enable `+org-live-pdf-mode' from the master file first"))
  (pcase-dolist (`(,dir ,pdf-dir ,_) +org-live-pdf--children)
    (let ((src (expand-file-name dir (+org-live-pdf--root))))
      (when (and pdf-dir (file-directory-p src))
        (dolist (f (directory-files src t "\\.org\\'"))
          (when (+org-live-pdf--entry f)
            (+org-live-pdf--build-child f pdf-dir)))))))

(define-minor-mode +org-live-pdf-mode
  "Keep the master PDF live in zathura and rebuild lecture PDFs on save.
Enable this from the master org file."
  :lighter " LivePDF"
  :global t
  (if +org-live-pdf-mode
      (progn
        (unless (and buffer-file-name (derived-mode-p 'org-mode))
          (setq +org-live-pdf-mode nil)
          (user-error "Enable this from the master org file"))
        ;; the master is the file with the #+INCLUDE: lines. Enabling from a
        ;; lecture instead silently makes *it* the master, which puts the
        ;; per-lecture PDF in the root and the combined one in lectures/.
        (unless (save-excursion
                  (goto-char (point-min))
                  (re-search-forward "^#\\+INCLUDE:" nil t))
          (setq +org-live-pdf-mode nil)
          (user-error "No #+INCLUDE: lines here -- enable this from the master file"))
        (require 'ox-latex nil t)
        ;; read here, in the master buffer, so its .dir-locals.el applies
        (setq +org-live-pdf--master (expand-file-name buffer-file-name)
              +org-live-pdf--children +org-live-pdf-children)
        (add-hook 'after-save-hook #'+org-live-pdf--on-save)
        (let ((tex (+org-live-pdf--export +org-live-pdf--master))
              (default-directory (file-name-directory +org-live-pdf--master)))
          (setq +org-live-pdf--proc
                (start-process
                 "org-live-pdf" "*org-live-pdf*" "latexmk"
                 "-pdf" "-pvc" "-interaction=nonstopmode"
                 (format "-auxdir=%s" +org-live-pdf-out-dir)
                 "-outdir=."
                 "-e" "$pdf_previewer=q(zathura)"
                 ;; poll 4x faster than the default 2s; auto-save-visited-mode
                 ;; already writes the file every 2s, so this is the other half
                 ;; of the type -> PDF latency
                 "-e" "$sleep_time=0.5"
                 "-e" "$failure_cmd=q(notify-send -u normal -h string:x-canonical-private-synchronous:latexmk 'LaTeX build failed' 'see *org-live-pdf*')"
                 tex)))
        (+org-live-pdf-build-all))
    (remove-hook 'after-save-hook #'+org-live-pdf--on-save)
    (when (process-live-p +org-live-pdf--proc)
      (kill-process +org-live-pdf--proc))
    (setq +org-live-pdf--proc nil
          +org-live-pdf--master nil
          +org-live-pdf--children nil)))

;; Doom disables flycheck's org-lint checker by default (it is slow on very
;; large org files). Lecture notes are small, and a broken #+INCLUDE: is much
;; cheaper to catch here than in a latexmk log.
(after! flycheck
  (setq-default flycheck-disabled-checkers
                (delq 'org-lint (default-value 'flycheck-disabled-checkers))))
