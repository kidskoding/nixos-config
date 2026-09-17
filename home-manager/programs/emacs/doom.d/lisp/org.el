;;; org.el -- org appearance, latex math, pdf viewing

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

;; Doom disables flycheck's org-lint checker by default (it is slow on very
;; large org files). Lecture notes are small, and a broken #+INCLUDE: is much
;; cheaper to catch here than in a latexmk log.
(after! flycheck
  (setq-default flycheck-disabled-checkers
                (delq 'org-lint (default-value 'flycheck-disabled-checkers))))
