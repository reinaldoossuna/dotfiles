(after! bibtex-completion
  (setq! bibtex-completion-bibliography "~/calibreLib.bib"
         bibtex-completion-pdf-field "file"
        bibtex-completion-notes-path "~/org/roam"))

(after! org-ref
  (setq! org-ref-bibliography-notes "~/org/roam"
        org-ref-default-bibliography "~/calibreLib.bib"
        org-ref-pdf-directory "~/Documents/Books"
        reftex-default-bibliography org-ref-default-bibliography))

(setq orb-preformat-keywords
      '("citekey" "title" "url" "author-or-editor" "keywords" "file")
      orb-process-file-keyword t
      orb-file-field-extensions '("pdf"))

(load! "biblio.el")
