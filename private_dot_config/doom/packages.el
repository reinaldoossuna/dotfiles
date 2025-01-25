(package! org-super-agenda)
(package! org-modern)

(package! calibredb)

(package! openwith)

(package! kconfig-mode)
(package! dts-mode)
(package! bitbake)

(package! kbd-mode
  :recipe (:host github :repo "reinaldoossuna/kbd-mode" ))

(package! systemd-mode)

(package! code-cells)
(package! docstr)

(package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))

(package! justl :recipe (:host github :repo "psibi/justl.el"))
(package! just-mode :recipe (:host github :repo "leon-barrett/just-mode.el"))

;; python dev modules
(package! numpydoc)
(package! lsp-pyright)

(package! age)
(package! chezmoi :recipe
                       (:host github
                        :repo "tuh8888/chezmoi.el"
                        :files (:defaults "extensions/*")
                        ))

(package! lsp-ltex-plus :recipe
  (:host github
         :repo "emacs-languagetool/lsp-ltex-plus"
        ))
