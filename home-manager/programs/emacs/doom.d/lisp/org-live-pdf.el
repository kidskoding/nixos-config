;;; org-live-pdf.el -- live latexmk build of a master org file

;; --- live PDF preview from a terminal frame ---
;; Enable `+org-live-pdf-mode' from the master org file, the one with the
;; #+INCLUDE: lines.
;;   master.org             -> master.pdf  (root, live in zathura via latexmk -pvc)
;;   any sibling .org       -> lectures/NAME.pdf, and in the book
;; <f5> shows the PDF of whichever org file you are in and keeps that one live
;; too, so a homework or a lecture hot-reloads in zathura as you type. The file
;; you are editing gets the -pvc watcher; the rest are built on demand.
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
(defvar +org-live-pdf--child nil
  "Absolute path of the org file `+org-live-pdf--child-proc' is watching.")
(defvar +org-live-pdf--child-proc nil
  "The `latexmk -pvc' process watching the child you are editing.
ponytail: one child at a time, like the master. Editing a second child retires
this watcher; make it an alist if you ever want several live at once.")

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

(defun +org-live-pdf--watch-child (org pdf-dir)
  "Keep ORG's standalone PDF in PDF-DIR live, the way the master's already is.
Re-exports ORG; if a watcher for it is already running that is all this does,
and `latexmk -pvc' picks the rewritten .tex up itself. Otherwise it retires the
previous child's watcher and starts one here.

This is what stops `auto-save-visited-mode' from spawning a latexmk every two
seconds, all racing on the same .aux in the out dir."
  (let ((org (expand-file-name org)))
    (if (and (equal org +org-live-pdf--child)
             (process-live-p +org-live-pdf--child-proc))
        (+org-live-pdf--export org)
      (when (process-live-p +org-live-pdf--child-proc)
        (kill-process +org-live-pdf--child-proc))
      (let* ((tex (+org-live-pdf--export org))
             (default-directory (+org-live-pdf--root)))
        (make-directory pdf-dir t)
        (setq +org-live-pdf--child org
              +org-live-pdf--child-proc
              (start-process
               "org-child-pdf" "*org-live-pdf*" "latexmk"
               "-pdf" "-pvc" "-interaction=nonstopmode"
               (format "-auxdir=%s" +org-live-pdf-out-dir)
               (format "-outdir=%s" pdf-dir)
               ;; Emacs opens zathura, not latexmk -- same reason as the master
               "-view=none"
               "-e" "$sleep_time=0.5"
               "-e" "$failure_cmd=q(notify-send -u normal -h string:x-canonical-private-synchronous:latexmk 'LaTeX build failed' 'see *org-live-pdf*')"
               tex))))))

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
        (+org-live-pdf--watch-child (expand-file-name buffer-file-name) (nth 1 entry))))))

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
                 ;; Emacs opens the viewer (see `+org-live-pdf--open-viewer'),
                 ;; not latexmk. latexmk only spawns it after its first
                 ;; successful build, which races with `+org-live-pdf-show'
                 ;; and leaves two zathuras on the same PDF.
                 "-view=none"
                 ;; poll 4x faster than the default 2s; auto-save-visited-mode
                 ;; already writes the file every 2s, so this is the other half
                 ;; of the type -> PDF latency
                 "-e" "$sleep_time=0.5"
                 "-e" "$failure_cmd=q(notify-send -u normal -h string:x-canonical-private-synchronous:latexmk 'LaTeX build failed' 'see *org-live-pdf*')"
                 tex)))
        (+org-live-pdf--open-viewer)
        (+org-live-pdf-build-all))
    (remove-hook 'after-save-hook #'+org-live-pdf--on-save)
    (dolist (p (list +org-live-pdf--proc +org-live-pdf--child-proc))
      (when (process-live-p p) (kill-process p)))
    (setq +org-live-pdf--proc nil
          +org-live-pdf--child nil
          +org-live-pdf--child-proc nil
          +org-live-pdf--master nil
          +org-live-pdf--children nil)))

(defun +org-live-pdf--pdf (&optional org)
  "Path of the PDF built from ORG, defaulting to the master.
For a tracked child that is its standalone PDF under the entry's PDF-DIR.
Returns nil for a file with no PDF of its own, which is the caller's cue to
fall back to the master."
  (let ((org (and (or org +org-live-pdf--master)
                  (expand-file-name (or org +org-live-pdf--master)))))
    (cond
     ((null org) nil)
     ((equal org +org-live-pdf--master)
      (concat (file-name-sans-extension +org-live-pdf--master) ".pdf"))
     (t (let ((pdf-dir (nth 1 (+org-live-pdf--entry org))))
          (when pdf-dir
            (expand-file-name (concat (file-name-base org) ".pdf")
                              (expand-file-name pdf-dir (+org-live-pdf--root)))))))))

(defun +org-live-pdf--find-master ()
  "Nearest .org file at or above the current buffer that has #+INCLUDE: lines.
Lets `+org-live-pdf-show' start the watcher from a homework or lecture buffer
without making *that* file the master, which is the trap the mode's own guard
warns about.
ponytail: reads every .org in each ancestor directory until one matches. Fine
for a notes tree a few levels deep; bound the walk if it ever gets slow."
  (let (found)
    (locate-dominating-file
     (or buffer-file-name default-directory)
     (lambda (dir)
       (setq found
             (seq-find (lambda (f)
                         (with-temp-buffer
                           (insert-file-contents f)
                           (goto-char (point-min))
                           (re-search-forward "^#\\+INCLUDE:" nil t)))
                       (directory-files dir t "\\.org\\'")))))
    found))

(defun +org-live-pdf--viewer-live-p (pdf)
  "Non-nil if zathura is already showing PDF.
Matched on the file name alone: latexmk hands the previewer whatever path it
used for the build, which may be relative to the master's directory."
  (let ((name (file-name-nondirectory pdf)))
    (seq-some (lambda (p)
                (let ((a (process-attributes p)))
                  ;; comm is ".zathura-wrappe" under Nix's wrapper script, and
                  ;; comm is truncated to 15 chars besides, so match loosely
                  (and (string-match-p "zathura" (or (alist-get 'comm a) ""))
                       (string-search name (or (alist-get 'args a) "")))))
              (list-system-processes))))

(defun +org-live-pdf--open-viewer (&optional pdf)
  "Open PDF, defaulting to the master's, in zathura unless it is already open.
On a first-ever build the PDF does not exist yet, so retry until latexmk has
written it.
ponytail: polls every 2s for as long as the watcher lives. A build that never
succeeds polls forever, which is cheap and stops the moment you turn the mode
off."
  (let ((pdf (or pdf (+org-live-pdf--pdf))))
    (cond ((+org-live-pdf--viewer-live-p pdf) nil)
          ((file-exists-p pdf) (start-process "zathura" nil "zathura" pdf))
          ((and +org-live-pdf-mode (process-live-p +org-live-pdf--proc))
           (run-with-timer 2 nil #'+org-live-pdf--open-viewer pdf)))))

(defun +org-live-pdf-show ()
  "Show the PDF for the current org file and keep the build live.
In the master that is the book; in a child with a PDF-DIR it is that file's own
standalone PDF; anywhere else it falls back to the book.  Safe to run as often
as you like: a second call never tears the watcher down, it reopens a viewer you
closed and otherwise does nothing.  Stop everything with `+org-live-pdf-mode'."
  (interactive)
  ;; 1. make sure a watcher is up, against the real master, whatever file we are in
  (cond
   ((not +org-live-pdf-mode)
    (let ((master (or (+org-live-pdf--find-master)
                      (user-error "No master org file (one with #+INCLUDE:) at or above %s"
                                  (abbreviate-file-name
                                   (or buffer-file-name default-directory))))))
      (with-current-buffer (find-file-noselect master) (+org-live-pdf-mode 1))))
   ;; latexmk itself died, so restart it against the same master
   ((not (process-live-p +org-live-pdf--proc))
    (let ((master +org-live-pdf--master))
      (+org-live-pdf-mode -1)
      (with-current-buffer (find-file-noselect master) (+org-live-pdf-mode 1)))))
  ;; 2. open whichever PDF belongs to this buffer
  (let* ((org (and buffer-file-name (expand-file-name buffer-file-name)))
         (pdf (+org-live-pdf--pdf org)))
    (unless pdf
      (message "%s has no standalone PDF; showing the master"
               (if org (file-name-nondirectory org) "This buffer"))
      (setq pdf (+org-live-pdf--pdf)))
    ;; put this file under a live watcher, which also builds it if it is new
    (when-let* ((pdf-dir (nth 1 (+org-live-pdf--entry org))))
      (+org-live-pdf--watch-child org pdf-dir))
    (if (+org-live-pdf--viewer-live-p pdf)
        (message "Live PDF already running: %s" (abbreviate-file-name pdf))
      (+org-live-pdf--open-viewer pdf))))

;; <f5> is the only unbound candidate in org-mode-map; C-c v, C-c p and the
;; C-c C-x prefixes are all taken by magit, projectile and org itself.
(map! :after org :map org-mode-map "<f5>" #'+org-live-pdf-show)
