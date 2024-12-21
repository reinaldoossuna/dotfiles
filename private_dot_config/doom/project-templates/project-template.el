;;; project-templates/project-template.el -*- lexical-binding: t; -*-

(defcustom cpp-templates '(("default" "cpp-template")
                           ("opengl" "opengl-template"))
  "AList with Name and Folder for template"
  :type '(list ('string 'string))
  :group 'templates)

(defun choose-template-from-list ()
  (interactive)
  (cadr (assoc
         (ivy-completing-read
          "Choose template: "
          cpp-templates) cpp-templates))
  )

(defcustom templates-directory "~/.doom.d/project-templates/"
  "Folder where the templates are stored"
  :type 'string
  :group 'templates)

(defcustom project-directory "~/Projects/CPP/"
  "Folder where the projects are stored"
  :type 'string
  :group 'templates)

(defun new-project (name)
  "Create new project from template"
  (interactive "sProject name: ")
  (let ((default-directory templates-directory)
        (template (choose-template-from-list))
        (project-path (concat project-directory name))
        )
    (copy-directory (expand-file-name template) project-path)
    (counsel-find-file project-path)
    )
  )

(provide 'project-template)
