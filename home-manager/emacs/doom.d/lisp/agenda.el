;;; agenda.el -- org agenda and capture

;; ~/org layout
;;   inbox.org        capture target, triage from here
;;   todo.org         tasks + reminders
;;   internships.org  Notion tracker DBs, rows = headings, columns = properties
;;   dsa.org          DSA practice tracker
;;   ideas.org        project ideas
;;   gcal/*.org       events, one file per calendar (org-gcal later)

(after! org
  (setq org-agenda-files (list org-directory (concat org-directory "gcal/"))
        org-default-notes-file (concat org-directory "inbox.org")
        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)" "KILL(k)"))
        org-log-done 'time
        org-agenda-span 'week
        org-agenda-start-on-weekday nil
        org-agenda-timegrid-use-ampm t
        org-deadline-warning-days 7
        org-capture-templates
        '(("t" "Todo" entry (file "inbox.org")
           "* TODO %?\n%U")
          ("r" "Reminder" entry (file+headline "todo.org" "Reminders")
           "* TODO %?\nSCHEDULED: %^T")
          ("e" "Event" entry (file "gcal/personal.org")
           "* %?\n%^T")
          ("i" "Idea" entry (file "ideas.org")
           "* %?\n%U"))))

(map! :leader
      (:prefix ("o" . "open")
       :desc "Agenda" "a" #'org-agenda-list)
      (:prefix ("n" . "notes")
       :desc "Capture" "n" #'org-capture))
