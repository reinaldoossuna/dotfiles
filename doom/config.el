;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Reinaldo Ossuna"
      user-mail-address "rossuna@tutanota.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
(setq doom-font (font-spec :family "IBMPlexMono" :size 16)
      doom-variable-pitch-font (font-spec :family "sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-horizon)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; Set variables
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; "_" is part of a Word in vim
(modify-syntax-entry ?_ "w")


(setq dotfiles-dir "~/.config/")
(setq org-roam-directory "~/org/roam")
(setq which-key-idle-delay .3)  ;; delay for the whick-key (bottom panel)
(setq company-idle-delay 0.3)
(setq treemacs-width 22)
(setq evil-snipe-scope 'whole-visible)
(setq +evil-want-o/O-to-continue-comments nil)

;; use packages
;;
(require 'org-tempo)
(require 'org-habit)
(require 'dap-cpptools)

(add-hook! 'c-mode-common-hook
  (modify-syntax-entry ?_ "w")
  'google-set-c-style
  )

(custom-set-variables
 '(flycheck-googlelint-verbose "3")
 '(flycheck-googlelint-filter "-legal/copyright,-build/include_subdir")
 '(flycheck-googlelint-linelength "120"))

;; darkmode in the pdf-view mode
(add-hook! 'pdf-view-mode-hook 'pdf-view-themed-minor-mode)

;; disable warning for large files
(setq large-file-warning-threshold nil)

;; Ace windows dont init propely
(use-package ace-window
  :config
  (setq aw-keys '(?a ?t ?n ?o ?d ?h ?r ?i ?s ?e))
  (setq aw-ignore-current t)
  (custom-set-faces!
    '(aw-leading-char-face
      :foreground "white" :background "red"
      :weight bold :height 1.5 :box (:line-width 3 :color "red"))))

(use-package! calibredb
  :defer t
  :config
  (setq calibredb-root-dir "~/Documents/Books/")
  (setq calibredb-format-all-the-icons t)
  (setq calibredb-format-character-icons t)
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir)))

(use-package! smudge
  :config
  (setq smudge-oauth2-client-secret "b989ddcc2bf14e938e4101e84e53f99b")
  (setq smudge-oauth2-client-id "2e5fa25d40914e3abaa9854db6918ad2")
  )

(use-package flycheck-posframe
  :after flycheck
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
  (setq flycheck-posframe-position 'frame-bottom-right-corner)
  (flycheck-posframe-configure-pretty-defaults)
  )

(after! 'flycheck
  (flycheck-add-next-checker 'c/c++-cppcheck
                             '(warning . c/c++-googlelint)))
;; dashboard
(setq fancy-splash-image
      (concat doom-private-dir "third-eye-logo.png"))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))


;; LSP
;; cpp
(after! ccls
  (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t))))

(setq lsp-clients-clangd-args '("-j=5"
                                "--fallback-style=google"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--function-arg-placeholders"
                                "--suggest-missing-includes"))

(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;;rust
(after! lsp-mode
  (setq lsp-rust-server 'rust-analyzer
        lsp-ui-sideline-actions-icon nil
        lsp-ui-sideline-show-diagnostics t
        lsp-rust-analyzer-server-display-inlay-hints t
        lsp-headerline-breadcrumb-enable t
        lsp-ui-doc-show-with-cursor nil

        ;;lsp-ui-sideline-enable nil
        ;;lsp-ui-sideline-show-symbol nil
        lsp-ui-sideline-show-hover nil
        ;;lsp-ui-doc-max-width  50
        ;;lsp-ui-doc-max-height  13
        ;;lsp-ui-doc-show-with-cursor nil
        ;;lsp-ui-doc-delay 0.5
        ;;lsp-ui-doc-position 'bottom
        lsp-signature-auto-activate nil
        lsp-signature-render-documentation t
        ;;lsp-ui-doc-mode t
        lsp-rust-clippy-preference "on"
        lsp-rust-analyzer-cargo-watch-command "clippy"
        lsp-diagnostics-provider :flycheck))

(setq rustic-test-arguments "-- --ignored")
(add-hook 'rustic-mode-hook #'format-all-mode)

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
               '(glsl-mode . "glsl"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "glslls")
                    :activation-fn (lsp-activate-on "glsl")
                    :server-id 'glsl)))

;; Projectile
(setq projectile-project-search-path '("/hdd/Projects")
      projectile-switch-project-action #'projectile-dired)

;;irc
(setq erc-server "irc.libera.chat"
      erc-nick "Ossuna"
      erc-user-full-name "Reinaldo Ossuna"
      erc-track-shorten-start 9
      erc-autojoin-channels-alist '(("irc-libera.chat" "#emacs"))
      erc-kill-buffer-on-part t)

(set-popup-rule! "^\\*LSP Error List" :size 0.2 :quit t :select t)


(with-eval-after-load 'dap-cpptools
  ;; Add a template specific for debugging Rust programs.
  ;; It is used for new projects, where I can M-x dap-edit-debug-template
  (dap-register-debug-template "Rust::CppTools Run Configuration"
                               (list :type "cppdbg"
                                     :request "launch"
                                     :name "Rust::Run"
                                     :MIMode "gdb"
                                     :miDebuggerPath "rust-gdb"
                                     :environment []
                                     :program "${workspaceFolder}/target/debug/XXX"
                                     :cwd "${workspaceFolder}"
                                     :console "external"
                                     :dap-compilation "cargo build"
                                     :dap-compilation-dir "${workspaceFolder}")))

(after! dap
  (setq dap-default-terminal-kind "integrated")
  (dap-auto-configure-mode +1))


(set-file-templates!
 '(
   ("/main\\.c\\(?:c\\|pp\\)$" :trigger "main" :mode c++-mode)
   ("\\.c\\(?:c\\|pp\\)$" :trigger "cpp" :mode c++-mode)
   ("\\.h\\(?:h\\|pp\\|xx\\)$" :trigger "hpp" :mode c++-mode)
   )
 )
(setq counsel-compile-local-builds (append  counsel-compile-local-builds '(
                                                                           "cmake --build build --config Debug"
                                                                           "cmake --build --preset=dev"
                                                                           "cmake --preset=dev"
                                                                           "cmake --build --preset=dev --target=run-exe"
                                                                           "cmake --build build --config 'Ninja Multi-Config'"
                                                                           "conan install . -if conan -s build_type=Debug --build=missing"
                                                                           ) ))
;; ;; Tab configs
;; (setq centaur-tabs-style "wave")
;; (setq centaur-tabs-set-icons t)
;; (setq centaur-tabs-set-bar 'under)
;; (setq x-underline-at-descent-line t)
;; (setq centaur-tabs-label-fixed-length 12)

(load! "keybinds.el")
(load! "pdf-continuous-scroll/config.el")
(load! "org-mode/config.el")

(require 'org-gcal)
(setq org-gcal-client-id "1541575121-art7jqhg6ci80kf8118qo9jmnjs0l7b2.apps.googleusercontent.com"
      org-gcal-client-secret "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"
      org-gcal-fetch-file-alist '(("reinaldo.ossuna@gmail.com" .  "~/org/schedule.org")
                                  ))

(setq org-latex-hyperref-template nil)
(setq org-latex-compiler "xelatex")
(setq org-latex-classes
      '(("structure"
         "\\documentclass[10pt,a4pater, twocolumn]{article}
\\input{structure.tex}
\\AtBeginDocument{\\thispagestyle{firstpage}}
\\AtEndDocument{\\printbibliography[title={Bibliography}]}
[NO-DEFAULT-PACKAGES]"
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
         ("\\paragraph{%s}" . "\\paragraph*{%s}"))

        ("report" "\\documentclass[11pt]{report}"
         ("\\part{%s}" . "\\part*{%s}")
         ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))

        ("book" "\\documentclass[11pt]{book}"
         ("\\part{%s}" . "\\part*{%s}")
         ("\\chapter{%s}" . "\\chapter*{%s}")
         ("\\section{%s}" . "\\section*{%s}")
         ("\\subsection{%s}" . "\\subsection*{%s}")
         ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(setq dap-auto-configure-features '(sessions locals controls tooltip))

(require 'transient)
(transient-define-prefix smudge-transient ()
  "Test Transient Title"
  ["Actions"
   ("e" "Volume Up"  smudge-controller-volume-up)
   ("n" "Volume Down" smudge-controller-volume-down)
   ("i" "Next Track" smudge-controller-next-track)
   ("k" "Previous Track" smudge-controller-previous-track)
   ("SPC" "Toggle Play" smudge-controller-toggle-play)
   ("s" "Shuffle" smudge-controller-toggle-shuffle)
   ("r" "Repeat" smudge-controller-toggle-repeat)
   ("m" "Un/Mute" smudge-controller-volume-mute-unmute)
   ])
