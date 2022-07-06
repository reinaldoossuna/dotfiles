;;; pdf-continuous-scroll/config.el -*- lexical-binding: t; -*-

(after! pdf-view
  ;; (map!
  ;;  (:map pdf-view-mode-map
  ;;   :nv "n" 'evil-collection-pdf-view-next-line-or-next-page
  ;;   :nv "e" 'evil-collection-pdf-view-previous-line-or-previous-page
  ;;   :nv "N" 'pdf-view-next-page
  ;;   :nv "E" 'pdf-view-previous-page
  ;;   ))
  (map!
   (:map pdf-view-mode-map
    :nv "j" 'image-roll-scroll-forward
    :nv "k" 'image-roll-scroll-backward
    :nv "J" 'image-roll-next-page
    :nv "K" 'image-roll-previous-page
    ))
  )
