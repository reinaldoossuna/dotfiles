(map!
 ;;(:desc "Toggle comment" "C-c C-c" #'evilnc-comment-or-uncomment-region)
 (:desc "Go to line" :nv "g l" #'evil-avy-goto-line
  :desc "next line nonblank" :nv "gs=" 'evilem-motion-next-line-first-non-blank
  ;; :nv "gss" 'evil-avy-goto-char-timer
  ;; :nv "gs/" 'evil-avy-goto-avy-move-regionchar-2
  )
 (:desc "copy line" :nv "ghl" 'avy-copy-line
  :desc "copy region" :nv "ghr" 'avy-copy-region
  :desc "move line" :nv "ghL" 'avy-move-line
  :desc "move region" :nv "ghR" 'avy-move-region)

 ;; wrap lines behaviour
 (:desc "End of line" :nv "$" 'evil-end-of-line
  :desc "End of visual line" :nv "g$" 'evil-end-of-visual-line
  )

 (:map evil-window-map
  :desc "enlarge" "|" (cmd! (evil-window-set-width 90))
  :desc "Ace window" "a" 'ace-window
  :desc "left" "<left>"     #'evil-window-left
  :desc "down" "<down>"     #'evil-window-down
  :desc "up" "<up>"     #'evil-window-up
  :desc "right" "<right>"     #'evil-window-right
  :desc "ace tab" "t" 'centaur-tabs-ace-jump
  )

 (:map doom-leader-search-map
  :desc "Search Marks" "r" #'counsel-evil-marks
  )

 (:map doom-leader-project-map
  ;;:desc "Debug config"
  ;;"G" "Ninja Multi-config" '(projectile--cmake-command ("cmake -S . -B build -G 'Ninja Multi-Config'"))
  :desc "Find recent file" "R" 'projectile-recentf
  :desc "Run project" "r"  'projectile-run-project
  :desc "grep" "/" '+default/search-project
  :desc "GDB" "G" 'projectile-run-gdb
  )
 (:map doom-leader-open-map
  :desc "Open vterm" "t" #'+vterm/here
  :desc "Calibredb" "c" 'calibredb
  :desc "Calc" "C" 'calc
  :desc "Spotify" "s" 'smudge-command-map
  :desc "Exercism" "e" 'exercism
  )
 (:map doom-leader-toggle-map
  :desc "Toggle vterm" "t" #'+vterm/toggle
  :desc "Pomodoro timer" "p" #'org-pomodoro
  :desc "Pomodoro extend timer" "P" #'org-pomodoro-extend-last-clock
  )
 (:map doom-leader-code-map
  :desc "Un/Comment region" "/" #'comment-or-uncomment-region
  :desc "List error" "x" 'flycheck-list-errors
  )

 (:map doom-leader-file-map
  :desc "dotfiles" "." (cmd! (doom-project-browse dotfiles-dir ) ))

 ;; pdf-mode
 ;; dark-mode toggle
 (:mode pdf-view-mode
  :map pdf-view-mode-map
  "zd" nil ;; removing this keybind. Doenst work!
  ;;n "d" 'pdf-view-scroll-up-or-next-page
  ;;n "u" 'pdf-view-scroll-down-or-previous-page
  :map doom-leader-toggle-map
  :desc "dark-mode" "d" 'pdf-view-themed-minor-mode)

 ;; rust mode
 ;;
 (:map rustic-mode-map
       (:localleader
        :desc "rerun" "r" 'lsp-rust-analyzer-rerun
        :desc "run" "R" 'lsp-rust-analyzer-run
        :desc "reload lsp" "l" 'lsp-rust-analyzer-reload-workspace
        :desc "errors list" "x" 'lsp-ui-flycheck-list
        :desc "expand macro" "e" 'lsp-make-rust-analyzer-expanded-macro
        :desc "cargo add" "a" 'rustic-cargo-add
        (:prefix ("t" . "cargo test")
         :desc "all ignored" "i" #'rustic-cargo-test-rerun)))
 (:mode rustic-mode
  :map doom-leader-toggle-map
  :desc "sideline" "s" 'lsp-ui-sideline-mode
  :desc "inlay hints" "h" 'lsp-rust-analyzer-inlay-hints-mode)
 (:mode rustic-mode
  :map doom-leader-project-map
  :desc "grep" "/" 'lsp-ivy-workspace-symbol)
 (:map docker-container-mode-map
       "K" 'docker-container-kill)

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


 (:map pdf-view-mode-map
  :n "C-o" 'pdf-history-backward
  :n "C-p" 'pdf-history-forward
  ;; :n "n" 'evil-collection-pdf-view-next-line-or-next-page
  ;; :n "e" 'evil-collection-pdf-view-previous-line-or-previous-page
  ;; :n "i" 'evil-scroll-column-right
  ;; :n "k" 'evil-scroll-column-left
  (:localleader
   "i" 'org-noter-insert-note
   "I" 'org-noter-insert-precise-note
   "a" 'pdf-annot-add-text-annotation
   "l" 'pdf-annot-list-annotations
   ))

 (:map smudge-command-map
  "<ESC>" nil
  :desc "previous" "b" 'smudge-controller-previous-track
  :desc "next" "f" 'smudge-controller-next-track
  :desc "vol Down" "n" 'smudge-controller-volume-down
  :desc "vol Up" "e" 'smudge-controller-volume-up
  :desc "select device" "d" 'smudge-select-device
  :desc "Toggle Play/Pause" "<SPC>" 'smudge-controller-toggle-play
  :desc "Toggle Shuffle" "s" 'smudge-controller-toggle-shuffle
  :desc "Restart Daemon" "r" 'restart-spotify-daemon
  (:prefix-map ("/" . "smudge search")
   :desc "track" "t" 'smudge-track-search
   :desc "playlist" "p" 'smudge-playlist-search))
 (:map smudge-track-search-mode-map
       "<RET>" 'smudge-track-select
       )

 (:map lsp-ui-flycheck-list-mode-map
       "<ESC>" 'lsp-ui-flycheck-list--quit
       "q" 'lsp-ui-flycheck-list--quit)
 (:map org-mode-map
  :ni "C-i" 'jupyter-inspect-at-point
  )

 (:map org-noter-notes-mode-map
  :localleader
  :prefix ("N" . "+noter")
  "n" 'org-noter-sync-next-note
  "p" 'org-noter-sync-prev-note
  "C" 'org-noter-sync-current-page-or-chapter
  "N" 'org-noter-sync-next-page-or-chapter
  "P" 'org-noter-sync-prev-page-or-chapter
  "c" 'org-noter-sync-current-note
  )
 (:map vterm-mode-map
       "C-k" 'vterm-send-escape
       )
 (:map outline-mode-map
  :n "C-j" 'outline-next-visible-heading
  :n "C-k" 'outline-previous-visible-heading
  )
 ;; (:after gud
 ;;         (:localleader
 ;;          (:prefix-map ("g" . "GDB")
 ;;           :desc "Add Break points" "b" #'gud-break
 ;;           :desc "Add TBreak points" "t" #'gud-tbreak
 ;;           :desc "Print" "p" #'gud-print
 ;;           :desc "Until" "u" #'gud-until
 ;;           :desc "Finish" "f" #'gud-finish
 ;;           :desc "Step" "s" #'gud-step
 ;;           :desc "Next" "n" #'gud-next
 ;;           )
 ;;          )
 ;;         )
 (:map compilation-mode-map
       (:localleader
        :n "k" 'kill-compilation
        :n "j" 'compilation-next-error
        :n "n" 'compilation-previous-error
        )
       )
 (:map treemacs-mode-map
       "O" 'treemacs-add-project-to-workspace
       "D" 'treemacs-remove-project-from-workspace
       "a" 'treemacs-mark-or-unmark-path-at-point
       )
 (:map doom-leader-workspace-map
  :desc "Switch to 1st workspace"   "!"   #'+workspace/switch-to-0
  :desc "Switch to 2nd workspace"   "@"   #'+workspace/switch-to-1
  :desc "Switch to 3rd workspace"   "#"   #'+workspace/switch-to-2
  :desc "Switch to 4th workspace"   "$"   #'+workspace/switch-to-3
  :desc "Switch to 5th workspace"   "%"   #'+workspace/switch-to-4
  :desc "Switch to 6th workspace"   "^"   #'+workspace/switch-to-5
  :desc "Switch to 7th workspace"   "&"   #'+workspace/switch-to-6
  :desc "Switch to 8th workspace"   "*"   #'+workspace/switch-to-7
  :desc "Switch to 9th workspace"   "("   #'+workspace/switch-to-8
  :desc "Switch to final workspace" ")"   #'+workspace/switch-to-final
  )

 (:map calc-mode-map
       "C-o" 'casual-main-menu
       )
 (:map dirvish-mode-map
  :n "TAB" #'dirvish-subtree-toggle
  :n "gh" #'dirvish-subtree-up
  :n "gd" #'dirvish-subtree-down
  :n "b" #'dirvish-quick-access
  :n "z" #'dirvish-history-jump
  :n "F" #'dirvish-layout-toggle
  )

 )
