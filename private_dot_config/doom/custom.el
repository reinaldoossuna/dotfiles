;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" default))
 '(docstr-trigger-alist
   '(("RET" . docstr--trigger-return) ("/" . docstr-trigger-csharp)
     ("/" . docstr-trigger-golang) ("-" . docstr-trigger-lua)
     ("RET" . docstr-trigger-lua-return) ("#" . docstr-trigger-python)
     ("#" . docstr-trigger-ruby) ("/" . docstr-trigger-rust)
     ("/" . docstr-trigger-swift)))
 '(package-selected-packages
   '(bitbake casual code-cells devdocs engrave-faces fish-mode jtsx org-id-cleanup
     org-notify po-mode systemd))
 '(safe-local-variable-values
   '((projectile-project-run-cmd . "cmake --build --preset=dev --target=run-exe")
     (projectile-project-test-cmd . "ctest --preset=dev")
     (projectile-project-compilation-cmd . "cmake --build --preset=dev")
     (projectile-project-configure-cmd . "cmake --preset=dev"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
