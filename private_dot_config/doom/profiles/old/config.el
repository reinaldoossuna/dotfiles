;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Reinaldo Ossuna"
      user-mail-address "reinaldo.ossuna@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
(setq doom-font (font-spec :family "Iosevka SS05" :size 18  :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 13)
      doom-symbol-font (font-spec :family "JuliaMono")
      doom-big-font (font-spec :family "JetBrainsMono" :size 24))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the defaultx
(setq doom-theme 'doom-tokyo-night)
(setq doom-tokyo-night-padded-modeline t)
(after! (evil avy doom-theme)
  (add-hook 'doom-load-theme-hook
            (lambda ()
              (set-face-attribute 'avy-lead-face-0 nil :background (cadr (assoc (intern "blue") doom-themes--colors)))
              (set-face-attribute 'evil-snipe-matches-face nil :background (cadr (assoc (intern "blue") doom-themes--colors)))
              )))

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
(setq which-key-idle-delay .3)  ;; delay for the whick-key (bottom panel)
(setq company-idle-delay 0.3)
(setq treemacs-width 22)
(setq +evil-want-o/O-to-continue-comments nil)

;; use packages
;;
(require 'dts-mode)
(require 'kdl-mode)
;;(require 'exercism)

(add-hook! 'c-mode-local-vars-hook
  (modify-syntax-entry ?_ "w"))

(add-hook! 'c-mode-hook
  (modify-syntax-entry ?_ "w"))

;; darkmode in the pdf-view mode
;; (add-hook! 'pdf-view-mode-hook 'pdf-view-themed-minor-mode)

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
  (setq calibredb-program "/usr/bin/calibredb")
  (setq calibredb-root-dir "~/Documents/Books/")
  (setq calibredb-format-all-the-icons t)
  (setq calibredb-format-character-icons t)
  (setq calibredb-db-dir (expand-file-name "metadata.db" calibredb-root-dir))
  )

(set-popup-rule! "^\\*calibredb-entry" :vslot :side 'right :size 0.4 :select nil)
(set-popup-rule! "^\\*Help" :side 'bottom :size 0.3 :select nil)
;; (^ \*undo-tree\* (+popup-buffer) (actions) (side . left) (size . 20) (window-width . 40) (window-height . 0.16) (slot . 2) (vslot) (window-parameters (ttl . 5) (quit . t) (select . t) (modeline) (autosave)))
(set-popup-rule! "^\\*undo-tree" :side 'right :select t :vslot 2)


;; (use-package! smudge
;; ;;   :config (progn
;; ;;             (setq smudge-oauth2-client-id "fd9cc9c4c59c4e259af68100f2b6c4c8")
;; ;;             (setq smudge-oauth2-client-secret  "ae2f4a6894cb451492ab782cf838ad41")
;; ;;             )
;; ;;   (setq smudge-transport 'connect)
;; ;;   )

(use-package flycheck-posframe
  :after flycheck
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
  (setq flycheck-posframe-position 'frame-bottom-right-corner)
  (flycheck-posframe-configure-pretty-defaults)
  )

;; dashboard
(setq fancy-splash-image
      (concat doom-user-dir "third-eye-logo.png"))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
(add-hook! '+doom-dashboard-mode-hook (hide-mode-line-mode 1) (hl-line-mode -1))
(setq-hook! '+doom-dashboard-mode-hook evil-normal-state-cursor (list nil))


;; LSP
;; cpp
(after! ccls
  (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t))))

(setq lsp-clients-clangd-args '("-j=5"
                                "--all-scopes-completion"
                                "--fallback-style=Chromium"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--function-arg-placeholders"
                                "--suggest-missing-includes"))

(setq +lsp-company-backends '(:separate company-capf company-yasnippet company-dabbrev-code))

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

;;; DAP Config

;; (require 'dap-cpptools)
;; (with-eval-after-load 'dap-cpptools
;;   ;; Add a template specific for debugging Rust programs.
;;   ;; It is used for new projects, where I can M-x dap-edit-debug-template
;;   (dap-register-debug-template "Rust::CppTools Run Configuration"
;;                                (list :type "cppdbg"
;;                                      :request "launch"
;;                                      :name "Rust::Run"
;;                                      :MIMode "gdb"
;;                                      :miDebuggerPath "rust-gdb"
;;                                      :environment []
;;                                      :program "${workspaceFolder}/target/debug/XXX"
;;                                      :cwd "${workspaceFolder}"
;;                                      :args []
;;                                      :console "external"
;;                                      :dap-compilation "cargo build"
;;                                      :dap-compilation-dir "${workspaceFolder}"))

;;   (dap-register-debug-template "cpp-template::Configuration"
;;                                (list :type "cppdbg"
;;                                      :request "launch"
;;                                      :name "cpp-template"
;;                                      :MIMode "gdb"
;;                                      :program "${workspaceFolder}/build/dev/cpp-template"
;;                                      :cwd "${workspaceFolder}"
;;                                      :valuesFormatting "PrettyPrinters"
;;                                      ;; :setupCommands: (list :description "enable pretty printing" :text "-enable-pretty-printing" :ignoreFailures "true")
;;                                      :args []
;;                                      ))
;;   )


;; (after! dap-mode
;;   (setq dap-default-terminal-kind "external")
;;   ;; (setq dap-external-terminal '("allacritty" "-t" "{title}"  "--hold" "-e" "exec {command}"))
;;   (dap-auto-configure-mode +1)
;;   (setq dap-auto-configure-features '(sessions locals controls tooltip expressions repl)))


(set-file-templates!
 '(
   ("/main\\.c\\(?:c\\|pp\\)$" :trigger "main" :mode c++-mode)
   ("\\.c\\(?:c\\|pp\\)$" :trigger "cpp" :mode c++-mode)
   ("\\.h\\(?:h\\|pp\\|xx\\)$" :trigger "hpp" :mode c++-mode)
   )
 )

(setq projectile-enable-cmake-presets t)
;; (setq counsel-compile-local-builds
;; ;;       (append  counsel-compile-local-builds
;; ;;                '(
;; ;;                  "cmake --build build --config Debug"
;; ;;                  "cmake --build --preset=dev"
;; ;;                  "cmake --preset=dev"
;; ;;                  "cmake --build --preset=dev --target=run-exe"
;; ;;                  "cmake --build build --config 'Ninja Multi-Config'"
;; ;;                  "cmake --build --preset=dev --target=install"
;; ;;                  "conan install . -s build_type=Debug --build=missing"
;; ;;                  ) ))

;;; Nov EPUB - reader
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

;;; dts-mode overlay
(add-to-list 'auto-mode-alist '("\\.overlay\\'" . dts-mode))

(defun my-nov-font-setup ()
  (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                           :height 1.2))
(add-hook 'nov-mode-hook 'my-nov-font-setup)
(setq nov-text-width 80)

;; Display time and date in the modeline
(display-time)
(setq display-time-day-and-date t)

(set-docsets! 'cc-mode "C++" "C")
(setq avy-timeout-seconds 0.2)
(setq serial-speed-history (list "115200" ;; Given twice because 115200 b/s is the most common speed
                                 "1200" "2400" "4800" "9600" "14400" "19200"
                                 "28800" "38400" "57600" "115200"
                                 ))

(setq uniquify-trailing-separator-p t)

(after! lsp-haskell
  (setq lsp-haskell-formatting-provider "fourmolu"))


(defun restart-spotify-daemon ()
  (interactive)
  (async-shell-command "systemctl restart --user spotifyd.service")
  )

(require 'openwith)

(openwith-mode t)

(setq openwith-associations
      (list
       (list (openwith-make-extension-regexp
              '("mpg" "mpeg" "mp3" "mp4"
                "avi" "wmv" "wav" "mov" "flv"
                "ogm" "ogg" "mkv"))
             "mpv" '(file))

       (list (openwith-make-extension-regexp
              '("epub"))
             "ebook-viewer" '(file))
       ))

(setq aw-ignored-buffers '("*Calc Trail*" " *LV*"))

(add-hook 'web-mode (lambda ()
                      (push '(?< . evil-surround-read-tag) evil-surround-pairs-alist)
                      (push '(?> . evil-surround-read-tag) evil-surround-pairs-alist)
                      ))

(use-package! lsp-tailwindcss
  :init
  (setq lsp-tailwindcss-add-on-mode t))

(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

(setq-hook! 'web-mode-hook +format-with-lsp nil)

;; (with-eval-after-load 'org (global-org-modern-mode))
(setq lsp-auto-execute-action nil)

(after! apheleia
  (setf (alist-get 'taplo apheleia-formatters)
        '("taplo" "fmt" filepath))
  (push '(conf-toml-mode . taplo) apheleia-mode-alist))

(define-derived-mode astro-mode web-mode "Astro")
(setq auto-mode-alist
      (append '((".*\\.astro\\'" . astro-mode))
              auto-mode-alist ))
(setq-hook! 'astro-mode-hook +format-with-lsp t
            )

(set-file-template! 'astro-mode
  :trigger "__.astro"
  :project t)


(setq! centaur-tabs-ace-jump-keys '(?a ?o ?r ?i ?s ?e ?t ?n ?d ?h))

(setq! uniquify-buffer-name-style 'post-forward-angle-brackets)

(define-derived-mode cppfront-mode cpp-mode "cppfront")
(setq auto-mode-alist
      (append '((".*\\.cpp2\\'" . cppfront-mode))
              auto-mode-alist ))

(add-hook! cppfront-mode-hook
           #'lsp-disconnect
           )
(after! lsp-mode
  ;; https://github.com/emacs-lsp/lsp-mode/issues/3577#issuecomment-1709232622
  (delete 'lsp-terraform lsp-client-packages))

(setq! doom-modeline-buffer-file-name-style 'buffer-name)

(require 'plstore)
(setq plstore-cache-passphrase-for-symmetric-encryption t)
(add-to-list 'plstore-encrypt-to '"36369EC51439B97EC8340CFBD0488FA6C2FC504C")

(after! ispell
  (setq ispell-dictionary "english,pt_BR"
        ispell-personal-dictionary "~/.hunspell_personal"
        )
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic  "english,pt_BR")
  )

(after! evil-easymotion

  (setq avy-style 'de-bruijn)
  (evilem-make-motion evilem-motion-evil-snipe-s #'evil-snipe-repeat
                      :pre-hook (save-excursion (call-interactively #'evil-snipe-s))
                      :bind ((evil-snipe-scope 'buffer)
                             (evil-snipe-enable-highlight)
                             (evil-snipe-enable-incremental-highlight))
                      )

  (evilem-make-motion evilem-motion-evil-snipe-S #'evil-snipe-repeat-reverse
                      :pre-hook (save-excursion (call-interactively #'evil-snipe-S))
                      :bind ((evil-snipe-scope 'buffer)
                             (evil-snipe-enable-highlight)
                             (evil-snipe-enable-incremental-highlight))
                      )

  (define-key evil-snipe-parent-transient-map "C-;"
              (evilem-create 'evil-snipe-repeat
                             :bind ((evil-snipe-scope 'buffer)
                                    (evil-snipe-enable-highlight)
                                    (evil-snipe-enable-incremental-highlight))))

  (define-key evilem-map "s" #'evilem-motion-evil-snipe-s)
  (define-key evilem-map "S" #'evilem-motion-evil-snipe-S)
  )

(after! evil-snipe
  (setq evil-snipe-scope 'whole-visible)
  (setq evil-snipe-spillover-scope 'whole-buffer)
  (setq evil-snipe-repeat-scope 'whole-buffer)
  (push '(?\[ "[[{(]") evil-snipe-aliases)
  )

(global-auto-revert-mode 1)

(setq browse-url-browser-function 'browse-url-firefox)
;; ;; Tab configs
(load! "keybinds.el")
;; (load! "pdf-continuous-scroll/config.el")
(load! "org-mode/config.el")
(load! "project-templates/project-template.el")

(setq! uniquify-buffer-name-style 'forward)
(setq-hook! 'python-mode-hook +format-with-lsp nil)
(setq python-shell-interpreter "ipython3")
(setq python-shell-interpreter-args "-i --simple-prompt --no-color-info")

(after! code-cells
  (fset 'code-cells-mode-map code-cells-mode-map)
  (map!
   (:map code-cells-mode-map
    :niv "C-c C-c" #'code-cells-eval
    :n "]]" 'code-cells-forward-cell
    :n "[[" 'code-cells-backward-cell)

   (:map python-mode-map
         (:localleader
          "r" 'run-python
          "m" 'code-cells-mode-map))
   )
   
  )

(add-hook! 'doom-scratch-buffer-hook
           '(flycheck-clear))

(setq shell-file-name (executable-find "zsh"))
