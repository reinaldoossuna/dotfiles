;;; org-mode/config.el -*- lexical-binding: t; -*-


(setq org-directory "~/org/")
(setq org-agenda-files '(
                         "~/org/todo.org"
                         "~/org/habits.org"
                         "~/org/notes.org"
                         "~/org/events.org"
                         "~/org/projects.org"
                         "~/org/deutsch.org"
                         "~/org/danish.org"
                         ))
(add-to-list 'org-modules 'org-habit)
(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)


(dolist (mode '(org-mode-hook
                ))
  (add-hook mode (lambda () (display-line-numbers-mode 0)))
  (add-hook 'org-mode-hook 'display-time-mode)
  ;; (add-hook 'org-mode-hook #'org-modern-mode)
  ;; (add-hook 'org-agenda-finalize-hook #'org-modern-agenda)
  (global-org-modern-mode)
  ;;(add-hook 'org-mode-hook 'writeroom-mode)
  )


;; set volume
;; volume in 0..65536 (2^16)
;; get 50 percent
(setq org-pomodoro-volume (format! "--volume %d"  (/ (* 65536 50 ) 100)))
(setq org-pomodoro-finished-sound-args org-pomodoro-volume)
(setq org-pomodoro-long-break-sound-args org-pomodoro-volume)
(setq org-pomodoro-short-break-sound-args org-pomodoro-volume)

(setq org-agenda-custom-commands
      '(("d" "today view"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                          :time-grid t
                          :date today
                          :todo "TODAY"
                          :scheduled today
                          :order 1))
                       (:discard (:anything t)))))
          (alltodo "" ((org-agenda-overriding-header "TODOs")
                       (org-super-agenda-groups
                        '(
                          (:name "Important"
                           :tag "Important"
                           :priority "A"
                           :order 6)
                          (:name "Issues"
                           :tag "Issue"
                           :order 12)
                          (:name "Projects"
                           :tag "Project"
                           :order 14)
                          (:name "Emacs"
                           :tag "Emacs"
                           :order 13)
                          (:name "Study"
                           :tag "study"
                           :order 15)
                          (:name "To read"
                           :tag "Read"
                           :order 30)
                          (:name "Waiting"
                           :todo "WAITING"
                           :order 20)
                          (:name "Ideas"
                           :todo "Idea"
                           :order 40)
                          (:discard (:tag ("Routine" "Daily")))))))))))

(defun tnez/src-cleanup ()
  (indent-region (point-min) (point-max)))
(add-hook 'org-babel-post-tangle-hook 'tnez/src-cleanup)

(use-package org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'horizontal-split
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   ;; Everything is relative to the main notes file
   org-noter-notes-search-path (list "~/org/roam")
   )
  )


(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("pys" . "src python :session"))
(add-to-list 'org-structure-template-alist '("cpp" . "src cpp :tangle no :noweb-ref xx"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("jupyter" . "src jupyter-python :session py"))


(setq org-journal-file-type 'monthly
      org-journal-date-format "%A, %Y-%m-%d")
