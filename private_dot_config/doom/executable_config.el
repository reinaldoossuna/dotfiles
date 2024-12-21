;;; -*- lexical-binding: t; -*-
;; [[file:config.org::*Variables][Variables:1]]
(setq home-row-keys '(?a ?t ?n ?o ?d ?h ?r ?i ?s ?e))
;; Variables:1 ends here

;; [[file:config.org::*Large files warning][Large files warning:1]]
(setq large-file-warning-threshold nil)
;; Large files warning:1 ends here

;; [[file:config.org::*Uniquify buffer name][Uniquify buffer name:1]]
(after! persp-mode
  (add-hook! 'persp-mode-hook :depth 5
             (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
             ))
;; Uniquify buffer name:1 ends here

;; [[file:config.org::*ID][ID:1]]
(setq user-full-name "Reinaldo Ossuna"
      user-mail-address "reinaldo.ossuna@gmail.com")
;; ID:1 ends here

;; [[file:config.org::*Font][Font:1]]
(setq doom-font (font-spec :family "Iosevka Term Curly" :size 18  :weight 'regular)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 13)
      doom-symbol-font (font-spec :family "JuliaMono")
      doom-big-font (font-spec :family "JetBrainsMono" :size 24))
;; Font:1 ends here

;; [[file:config.org::*Theme][Theme:1]]
(setq doom-theme 'doom-vibrant)
(setq doom-vibrant-padded-modeline t)
;; Theme:1 ends here

;; [[file:config.org::*Display line][Display line:1]]
(setq display-line-numbers-type t)
;; Display line:1 ends here

;; [[file:config.org::*Dashboard][Dashboard:1]]
(setq fancy-splash-image
      (concat doom-user-dir "third-eye-logo.png"))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))
;; Dashboard:1 ends here

;; [[file:config.org::*Coding][Coding:1]]
(map!
 (:desc "Go to line" :nv "gl" #'evil-avy-goto-line
  :desc "copy line" :nv "ghl" 'avy-copy-line
  :desc "copy region" :nv "ghr" 'avy-copy-region
  :desc "move line" :nv "ghL" 'avy-move-line
  :desc "move region" :nv "ghR" 'avy-move-region
 )
 (:map doom-leader-code-map
  :desc "Un/Comment region" "/" #'comment-or-uncomment-region
  )
 (:map doom-leader-project-map
  :desc "Find recent file" "R" 'projectile-recentf
  :desc "Run project" "r"  'projectile-run-project
  :desc "GDB" "G" 'projectile-run-gdb
  )
 )
;; Coding:1 ends here

;; [[file:config.org::*Coding][Coding:2]]
(map!
 (:map compilation-mode-map
       (:localleader
        :n "k" 'kill-compilation
        :n "j" 'compilation-next-error
        :n "n" 'compilation-previous-error
        )
       )
 )
;; Coding:2 ends here

;; [[file:config.org::*ORG][ORG:1]]
(setq org-roam-directory "~/org/roam")
(setq org-directory "~/org/")

(after! org
  (global-org-modern-mode)
  )
;; ORG:1 ends here

;; [[file:config.org::*org-latex][org-latex:1]]
(require 'ox-latex)
(after! org
  (setq org-latex-compiler "lualatex")
  (setq org-latex-pdf-process
      '("latexmk -f -pdf -%latex -interaction=nonstopmode -synctex=1 -file-line-error -shell-escape -output-directory=%o %f"))
  (setq org-latex-src-block-backend 'minted)
  (add-to-list 'org-latex-packages-alist '("newfloat" "minted"))
  (setq org-latex-minted-options '(("bgcolor" . "bg") ("breaklines")))
  (setq org-export-with-toc nil)
  )
;; org-latex:1 ends here

;; [[file:config.org::*org-latex][org-latex:2]]
(setq org-latex-classes
        '(("article"
           "\\RequirePackage{fix-cm}
\\PassOptionsToPackage{svgnames}{xcolor}
\\documentclass[11pt]{article}
\\usepackage{fontspec}
\\usepackage{libertine}
\\usepackage{datetime2}
\\usepackage{sectsty}
\\allsectionsfont{\\sffamily}
\\usepackage{enumitem}
\\setlist[description]{style=unboxed,font=\\sffamily\\bfseries}
\\usepackage{listings}
\\lstset{frame=single,aboveskip=1em,
	framesep=.5em,backgroundcolor=\\color{AliceBlue},
	rulecolor=\\color{LightSteelBlue},framerule=1pt}
\\usepackage{xcolor}
\\newcommand\\basicdefault[1]{\\scriptsize\\color{Black}\\ttfamily#1}
\\lstset{basicstyle=\\basicdefault{\\spaceskip1em}}
\\usepackage[a4paper,top=3.5cm,left=3cm,right=3cm,bottom=2.5cm]{geometry}
\\usepackage[bf,sf,footnotesize,indent]{caption}
\\setlength{\\captionmargin}{0.8cm}
\\renewcommand{\\captionfont}{\\sffamily\\footnotesize\\bfseries}
\\parindent 1.27cm
\\parskip   6pt
\\flushbottom
\\usepackage{parskip}
\\makeatletter
\\renewcommand{\\maketitle}{%
  \\begingroup\\parindent0pt
  \\sffamily
  \\Huge{\\bfseries\\@title}\\par\\bigskip
  \\LARGE{\\bfseries\\@author}\\par\\medskip
  \\normalsize\\@date\\par\\bigskip
  \\endgroup\\@afterindentfalse\\@afterheading}
\\makeatother
[DEFAULT-PACKAGES]
\\AtBeginDocument{\\renewcommand{\\UrlFont}{\\ttfamily}}
[PACKAGES]
[EXTRA]

\\usepackage{tcolorbox}
\\tcbuselibrary{listings, minted, skins}
\\tcbset{listing engine=minted}

\\definecolor{bg}{RGB}{22,43,58}
"
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))

          ("report" "\\documentclass[11pt]{report}"
           ("\\part{%s}" . "\\part*{%s}")
           ("\\chapter{%s}" . "\\chapter*{%s}")
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))

          ("sbc" "\\documentclass[12pt]{article}
\\usepackage{sbc-template}
\\bibliographystyle{sbc}
\\usepackage{graphicx,url}
\\usepackage[utf8]{inputenc}
\\usepackage[brazil]{babel}
\\usepackage[latin1]{inputenc}

\\sloppy

\\AtBeginDocument{\\definecolor{bg}{rgb}{0.95,0.95,0.95}}
\\AtEndDocument{\\printbibliography}
[PACKAGES]
[EXTRA]"
           ("\\section{%s}" . "\\section*{%s}")
           ("\\subsection{%s}" . "\\subsection*{%s}")
           ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
           ("\\paragraph{%s}" . "\\paragraph*{%s}")
           ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
  ))
;; org-latex:2 ends here

;; [[file:config.org::*jupyter][jupyter:1]]
(add-to-list 'org-default-properties "header-args")
(add-to-list 'org-structure-template-alist '("jupyter" . "src jupyter-python"))

(setq my/jupyter-runtime-folder (expand-file-name "~/.local/share/jupyter/runtime"))

(defun my/list-jupyter-kernel-files ()
  (mapcar
   (lambda (file) (cons (car file) (cdr (assq 'shell_port (json-read-file (car file))))))
   (sort
    (directory-files-and-attributes my/jupyter-runtime-folder t ".*kernel.*json$")
    (lambda (x y) (not (time-less-p (nth 6 x) (nth 6 y)))))))

(defun my/get-open-ports ()
  (mapcar
   #'string-to-number
   (split-string (shell-command-to-string "ss -tulpnH | awk '{print $5}' | sed -e 's/.*://'") "\n")))

(defun my/select-jupyter-kernel ()
  (let ((ports (my/get-open-ports))
        (files (my/list-jupyter-kernel-files)))
    (completing-read
     "Jupyter kernels: "
     (seq-filter
      (lambda (file)
        (member (cdr file) ports))
      files)))
  )

(defun my/insert-jupyter-kernel ()
  "Insert a path to an active Jupyter kernel into the buffer"
  (interactive)
  (insert (my/select-jupyter-kernel)))

(defun my/jupyter-connect-repl ()
  "Open emacs-jupyter REPL, connected to a Jupyter kernel"
  (interactive)
  (jupyter-connect-repl (my/select-jupyter-kernel) nil nil nil t))

(defun my/jupyter-console ()
  "Open Jupyter Console, connected to a Jupyter kernel"
  (interactive)
  (start-process "jupyter-console" nil "zellij" "run" "--" "jupyter" "console" "--existing"
                 (file-name-nondirectory (my/select-jupyter-kernel))))

(defun my/jupyter-cleanup-kernels ()
  (interactive)
  (let* ((ports (my/get-open-ports))
         (files (my/list-jupyter-kernel-files))
         (to-delete (seq-filter
                     (lambda (file)
                       (not (member (cdr file) ports)))
                     files)))
    (when (and (length> to-delete 0)
               (y-or-n-p (format "Delete %d files?" (length to-delete))))
      (dolist (file to-delete)
        (delete-file (car file))))))

(with-eval-after-load 'jupyter-client
  (defun my/jupyter-remove-empty-async-results (args)
    (let*
        ((req (nth 1 args))
         (msg (nth 2 args))
         (is-org-request (eq (type-of req) 'jupyter-org-request)))
      (when is-org-request
        (jupyter-with-message-content msg (status payload)
          (when (and (jupyter-org-request-async-p req)
                     (equal status "ok")
                     (not (jupyter-org-request-id-cleared-p req)))
            (jupyter-org--clear-request-id req)
            (org-with-point-at (jupyter-org-request-marker req)
              (org-babel-remove-result)))))
      args))

  (unless (advice-member-p #'my/jupyter-remove-empty-async-results 'jupyter-handle-execute-reply)
    (advice-add 'jupyter-handle-execute-reply :filter-args #'my/jupyter-remove-empty-async-results)))
;; jupyter:1 ends here

;; [[file:config.org::*Latex][Latex:1]]
(add-hook! 'LaTeX-mode-hook
           (TeX-engine-set 'luatex)
           (TeX-fold-mode t)
  )
(setq-hook! 'LaTeX-mode-hook
  TeX-PDF-mode t
  TeX-command-extra-options "-synctex=1"
  TeX-source-correlate-mode t
  )
;; Latex:1 ends here

;; [[file:config.org::*Calibre][Calibre:1]]
(use-package! calibredb
  :defer t
  :config
  (setq! calibredb-program "/usr/bin/calibredb"
         calibredb-root-dir "~/Documents/Books/"
         calibredb-format-all-the-icons t
         calibredb-format-character-icons t
         calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir)
         )
  (set-popup-rule! "^\\*calibredb-entry" :vslot 5 :side 'right :size 0.4 :select nil)
  (set-popup-rule! "^\\*Help" :side 'bottom :size 0.3 :select nil)
  (set-popup-rule! "^\\*undo-tree" :side 'right :select t :vslot 2)
  )
;; Calibre:1 ends here

;; [[file:config.org::*Keybindings][Keybindings:1]]
(map!
 (:map doom-leader-open-map
       "c" #'calibredb)
 (:map calibredb-search-mode-map
  :n "?" 'calibredb-dispatch
  :n "/" 'calibredb-search-live-filter
  :n "<RET>" 'calibredb-find-file
  :n "o" 'calibredb-find-file
  :n "O" 'calibredb-find-file-other-frame
  :n "r" 'calibredb-search-refresh-and-clear-filter
  :n "q" 'calibredb-search-quit
  :n "a" 'calibredb-add
  :n "F" 'calibredb-fetch-and-set-metadata-by-author-and-title
  )
 )
;; Keybindings:1 ends here

;; [[file:config.org::*LSP][LSP:1]]
(after! lsp-mode
  (setq! lsp-rust-server 'rust-analyzer
         lsp-ui-sideline-actions-icon nil
         lsp-ui-sideline-show-diagnostics t
         lsp-rust-analyzer-server-display-inlay-hints t
         lsp-headerline-breadcrumb-enable t
         lsp-ui-doc-show-with-cursor nil
         lsp-ui-sideline-show-hover nil
         lsp-signature-auto-activate nil
         lsp-signature-render-documentation t
         lsp-rust-clippy-preference "on"
         lsp-rust-analyzer-cargo-watch-command "clippy"
         lsp-diagnostics-provider :flycheck))
;; LSP:1 ends here

;; [[file:config.org::*LSP][LSP:2]]
(after! lsp-clangd
  (set-lsp-priority! 'clangd 2)
  (setq lsp-clients-clangd-args '("-j=5"
                                  "--all-scopes-completion"
                                  "--fallback-style=Chromium"
                                  "--background-index"
                                  "--clang-tidy"
                                  "--completion-style=detailed"
                                  "--header-insertion=never"
                                  "--function-arg-placeholders"
                                  "--suggest-missing-includes"))
  (set-popup-rule! "^\\*LSP Error List" :size 0.2 :quit t :select t)
  )
;; LSP:2 ends here

;; [[file:config.org::*Ace window][Ace window:1]]
(use-package! ace-window
  :config
  (setq! aw-keys home-row-keys
         aw-ignore-current t)
  (custom-set-faces!
    '(aw-leading-char-face
      :foreground "white" :background "red"
      :weight bold :height 1.5 :box (:line-width 3 :color "red"))))
;; Ace window:1 ends here

;; [[file:config.org::*Evil][Evil:1]]
(after! evil
  (modify-syntax-entry ?_ "w")
  )
;; Evil:1 ends here

;; [[file:config.org::*Evil][Evil:2]]
(map!
 :nv "+" 'evil-numbers/inc-at-pt
 )
;; Evil:2 ends here

;; [[file:config.org::*Snipe][Snipe:1]]
(after! evil-snipe
  (setq! evil-snipe-scope 'whole-visible
         evil-snipe-spillover-scope 'whole-buffer
         evil-snipe-repeat-scope 'whole-buffer)
  )
;; Snipe:1 ends here

;; [[file:config.org::*Avy][Avy:1]]
(after! avy
  (setq! avy-style 'de-bruijn
         avy-keys  home-row-keys
         )
  )
;; Avy:1 ends here

;; [[file:config.org::*Keybindings][Keybindings:1]]
(map! :map evil-window-map
      :desc "Ace window" "a" 'ace-window
      :desc "enlarge" "|" (cmd! (evil-window-set-width 90))
      )
;; Keybindings:1 ends here

;; [[file:config.org::*Vterm][Vterm:1]]
(setq shell-file-name (executable-find "zsh"))

(after! vterm
  (setq-default vterm-shell shell-file-name)
  )
;; Vterm:1 ends here

;; [[file:config.org::*Keybindings][Keybindings:1]]
(map!
 (:map doom-leader-open-map
       "t" #'+vterm/here
       "T" nil)
 (:map doom-leader-toggle-map
  :desc "Toggle vterm" "t" #'+vterm/toggle)
 (:map vterm-mode-map
       "C-k" #'vterm-send-escape)
 )

(which-key-add-key-based-replacements "SPC t t" "Toggle vterm")
(which-key-add-key-based-replacements "SPC o t" "Open vterm here")
;; Keybindings:1 ends here

;; [[file:config.org::*Dirvish][Dirvish:1]]
(after! dirvish
  (setq dirvish-quick-access-entries
        '(("h" "~/"                          "Home")
          ("d" "~/Documents/"                "Documents")
          ("D" "~/Downloads/"                "Downloads")))

  (setq!
   dired-listing-switches "-l --almost-all --human-readable --group-directories-first --no-group"
   dirvish-hide-details t
   dirvish-attributes '(vc-state subtree-state nerd-icons collapse git-msg file-time file-size)
   dirvish-mode-line-format '(:left (sort symlink) :right (omit yank index))
   )
  )
;; Dirvish:1 ends here

;; [[file:config.org::*Projectile][Projectile:1]]
(setq
 projectile-project-search-path '(("~/Projects/" . 2))
 projectile-enable-cmake-presets t)
;; Projectile:1 ends here

;; [[file:config.org::*Openwith][Openwith:1]]
(use-package! openwith
  :config
  (openwith-mode t)

  (setq openwith-associations
        (list
         (list (openwith-make-extension-regexp
                '("mpg" "mpeg" "mp3" "mp4"
                  "avi" "wmv" "wav" "mov" "flv"
                  "ogm" "ogg" "mkv"))
               "mpv" '(file))

         (list (openwith-make-extension-regexp
                '("epub" "azw3"))
               "ebook-viewer" '(file))
         ))
  )
;; Openwith:1 ends here

;; [[file:config.org::*Ispell][Ispell:1]]
(after! ispell
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic  "pt_BR,english")
  (setq ispell-dictionary "pt_BR,english"
        ispell-personal-dictionary "~/.hunspell_personal"
        )
  )

(after! flyspell
  (setq flyspell-lazy-idle-seconds 3)
  (setq flyspell-lazy-window-idle-seconds 30))
;; Ispell:1 ends here

;; [[file:config.org::*Just][Just:1]]
(after! projectile
  (add-to-list 'projectile-project-root-files "justfile")
  (add-to-list 'projectile-project-types '(just marker-files ("justfile") project-file "justfile" compilation-dir nil
                                           configure-command "just config" compile-command "just build" test-command
                                           "just test" install-command "just install" package-command nil
                                           run-command "just run"))
  )

(use-package! justl
  :config
  (map!
   (:map justl-mode-map
    :n "e" #'justl-exec-recipe
    :n "E" #'justl-exec-vterm
    :n "w" #'justl-no-exec-vterm
    :n "f" #'justl-go-to-file
    )
   :leader :desc "justl" :n "j" #'justl
   ))
;; Just:1 ends here

;; [[file:config.org::*Python][Python:1]]
(after! python
  (setq! +python-ipython-command '("/usr/bin/ipython" "-i" "--simple-prompt" "--no-color-info"))
  (add-hook 'python-mode-hook 'code-cells-mode-maybe)
(after! code-cells
  (map!
   :map code-cells-mode-map
   "C-n" #'code-cells-forward-cell
   :desc "execute cell" "C-c C-c" #'code-cells-eval
   :desc "execute buffer" "C-c C-b" #'python-shell-send-buffer
   :localleader
   :desc "cells" "c" 'code-cells-mode-map
   ))
  )
;; Python:1 ends here

;; [[file:config.org::*Rust][Rust:1]]
(after! rustic rust
  (map!
   :map rustic-mode-map
   :localleader
   :desc "cargo outdated"       "o" #'rustic-cargo-outdated
   :desc "cargo add"            "a" #'rustic-cargo-add
   :desc "cargo add missing"    "A" #'rustic-cargo-add-missing-dependencies
   :desc "visic Cargo.toml"     "t" #'lsp-rust-analyzer-open-cargo-toml
))
;; Rust:1 ends here
