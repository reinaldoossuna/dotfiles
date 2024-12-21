(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7e377879cbd60c66b88e51fad480b3ab18d60847f31c435f15f5df18bdb18184" "38c0c668d8ac3841cb9608522ca116067177c92feeabc6f002a27249976d7434" "f4d1b183465f2d29b7a2e9dbe87ccc20598e79738e5d29fc52ec8fb8c576fcfd" "9013233028d9798f901e5e8efb31841c24c12444d3b6e92580080505d56fd392" "4594d6b9753691142f02e67b8eb0fda7d12f6cc9f1299a49b819312d6addad1d" "7ec8fd456c0c117c99e3a3b16aaf09ed3fb91879f6601b1ea0eeaee9c6def5d9" "13096a9a6e75c7330c1bc500f30a8f4407bd618431c94aeab55c9855731a95e1" "a9eeab09d61fef94084a95f82557e147d9630fbbb82a837f971f83e66e21e5ad" default))
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(org-agenda-files
   '("/home/nardo/org/events.org" "/home/nardo/org/gcal.org" "/home/nardo/org/habits.org" "/home/nardo/org/journal.org" "/home/nardo/org/notes.org" "/home/nardo/org/projects.org" "/home/nardo/org/todo.org"))
 '(org-preview-latex-process-alist
   '((dvipng :programs
      ("latex" "dvipng")
      :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust
      (1.0 . 1.0)
      :latex-compiler
      ("lualatex -interaction nonstopmode -output-directory %o %f")
      :image-converter
      ("dvipng -D %D -T tight -o %O %f")
      :transparent-image-converter
      ("dvipng -D %D -T tight -bg Transparent -o %O %f"))
     (dvisvgm :programs
      ("latex" "dvisvgm")
      :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :image-input-type "dvi" :image-output-type "svg" :image-size-adjust
      (1.7 . 1.5)
      :latex-compiler
      ("latex -interaction nonstopmode -output-directory %o %f")
      :image-converter
      ("dvisvgm %f --no-fonts --exact-bbox --scale=%S --output=%O"))
     (imagemagick :programs
      ("latex" "convert")
      :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :image-input-type "pdf" :image-output-type "png" :image-size-adjust
      (1.0 . 1.0)
      :latex-compiler
      ("pdflatex -interaction nonstopmode -output-directory %o %f")
      :image-converter
      ("convert -density %D -trim -antialias %f -quality 100 %O"))))
 '(package-selected-packages
   '(fish-mode code-cells po-mode org-id-cleanup org-notify bitbake systemd casual))
 '(safe-local-variable-values
   '((org-babel-default-header-args:jupyter-python
      (:session . "scm")
      (:kernel . "scm")
      (:results . "replace")
      (:async . "yes"))
     (org-babel-default-header-args:jupyter-python quote
      ((:session . "scm")
       (:kernel . "scm")
       (:results . "replace")
       (:async . "yes")))
     (org-babel-default-header-args . jupyter-python)
     (python-shell-interpreter-args . "-i --simple-prompt --no-color-info")
     (python-shell-interpreter . "~/Documents/SCM/.venv/bin/ipython3")
     (python-shell-interpreter-args car
      '("-i" "--simple-prompt" "--no-color-info")
      " ")
     (ssh-deploy-on-explicit-save . 1)
     (ssh-deploy-async . 1))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:foreground "white" :background "red" :weight bold :height 1.5 :box (:line-width 3 :color "red")))))
 '(ts-fold-replacement-face ((t (:foreground unspecified :box nil :inherit font-lock-comment-face :weight light)))))
