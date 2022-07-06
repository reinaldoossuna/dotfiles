(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#1b1d1e" "#d02b61" "#60aa00" "#d08928" "#6c9ef8" "#b77fdb" "#00aa80" "#dddddd"])
 '(custom-safe-themes
   '("f91395598d4cb3e2ae6a2db8527ceb83fed79dbaf007f435de3e91e5bda485fb" "d268b67e0935b9ebc427cad88ded41e875abfcc27abd409726a92e55459e0d01" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "a9a67b318b7417adbedaab02f05fa679973e9718d9d26075c6235b1f0db703c8" default))
 '(exwm-floating-border-color "#303030")
 '(fci-rule-color "#505050")
 '(flycheck-googlelint-filter "-legal/copyright,-build/include_subdir")
 '(flycheck-googlelint-linelength "120")
 '(flycheck-googlelint-verbose "3")
 '(highlight-tail-colors ((("#212b1b" "#212b1b") . 0) (("#182b27" "#182b27") . 20)))
 '(ibuffer-saved-filter-groups
   '(("default"
      ("PDF"
       (mode . pdf-view-mode))
      ("Project: .doom.d"
       (projectile-root ".doom.d" . "/home/nardo/.doom.d/"))
      ("Project: actix-web-basic"
       (projectile-root "actix-web-basic" . "/hdd/Projects/RUST/actix-web-basic/")))))
 '(ibuffer-saved-filters
   '(("programming"
      (or
       (derived-mode . prog-mode)
       (mode . ess-mode)
       (mode . compilation-mode)))
     ("text document"
      (and
       (derived-mode . text-mode)
       (not
        (starred-name))))
     ("TeX"
      (or
       (derived-mode . tex-mode)
       (mode . latex-mode)
       (mode . context-mode)
       (mode . ams-tex-mode)
       (mode . bibtex-mode)))
     ("web"
      (or
       (derived-mode . sgml-mode)
       (derived-mode . css-mode)
       (mode . javascript-mode)
       (mode . js2-mode)
       (mode . scss-mode)
       (derived-mode . haml-mode)
       (mode . sass-mode)))
     ("gnus"
      (or
       (mode . message-mode)
       (mode . mail-mode)
       (mode . gnus-group-mode)
       (mode . gnus-summary-mode)
       (mode . gnus-article-mode)))))
 '(jdee-db-active-breakpoint-face-colors (cons "#1b1d1e" "#fc20bb"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1b1d1e" "#60aa00"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1b1d1e" "#505050"))
 '(objed-cursor-color "#d02b61")
 '(org-agenda-files
   '("/hdd/Documents/Control of Dynamic Systems/note.org" "/home/nardo/org/todo.org" "/home/nardo/org/habits.org" "/home/nardo/org/notes.org" "/home/nardo/org/events.org" "/home/nardo/org/projects.org"))
 '(package-selected-packages
   '(ox-latex-subfigure svg-lib jupyter flycheck-clang-tidy dash-docs simple-httpd websocket plantuml-mode flycheck-google-cpplint org-fancy-priorities pamparam anki-connect org-drill perspective org-super-agenda lsp-treemacs vterm-toggle pkgbuild-mode org-roam-bibtex nov calibredb arduino-mode))
 '(pdf-view-midnight-colors (cons "#dddddd" "#1b1d1e"))
 '(rustic-ansi-faces
   ["#1b1d1e" "#d02b61" "#60aa00" "#d08928" "#6c9ef8" "#b77fdb" "#00aa80" "#dddddd"])
 '(vc-annotate-background "#1b1d1e")
 '(vc-annotate-color-map
   (list
    (cons 20 "#60aa00")
    (cons 40 "#859f0d")
    (cons 60 "#aa931a")
    (cons 80 "#d08928")
    (cons 100 "#d38732")
    (cons 120 "#d6863d")
    (cons 140 "#da8548")
    (cons 160 "#ce8379")
    (cons 180 "#c281aa")
    (cons 200 "#b77fdb")
    (cons 220 "#bf63b2")
    (cons 240 "#c74789")
    (cons 260 "#d02b61")
    (cons 280 "#b0345c")
    (cons 300 "#903d58")
    (cons 320 "#704654")
    (cons 340 "#505050")
    (cons 360 "#505050")))
 '(vc-annotate-very-old-color nil)
 '(warning-suppress-types '((after-save-hook))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:foreground "white" :background "red" :weight bold :height 1.5 :box (:line-width 3 :color "red")))))
 '(ts-fold-replacement-face ((t (:foreground nil :box nil :inherit font-lock-comment-face :weight light)))))
