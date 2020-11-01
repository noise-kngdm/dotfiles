 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;  ▄▄█▀██▀████████▄█████▄  ▄█▀██▄  ▄██▀██ ▄██▀███ ;;
 ;; ▄█▀   ██ ██    ██    ██ ██   ██ ██▀  ██ ██   ▀▀ ;;
 ;; ██▀▀▀▀▀▀ ██    ██    ██  ▄█████ ██      ▀█████▄ ;;
 ;; ██▄    ▄ ██    ██    ██ ██   ██ ██▄    ▄█▄   ██ ;;
 ;;  ▀█████▀████  ████  ████▄████▀██▄█████▀ ██████▀ ;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;                   noise-kngdm                   ;; 
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(beacon-color "#d33682")
 '(custom-enabled-themes (quote (dracula)))
 '(custom-safe-themes
   (quote
    ("405d92fa9637ad38650c48c797b8e7e595289fbb7406f1e24bcc831fefed0418" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "24714e2cb4a9d6ec1335de295966906474fdb668429549416ed8636196cb1441" "63df625509cec7b2b7deba1d48ef07ffbee99c735a95d130ad9d1fc3df8b9a34" default)))
 '(fci-rule-color "#073642")
 '(flycheck-color-mode-line-face-to-color (quote mode-line-buffer-id))
 '(frame-background-mode (quote dark))
 '(org-agenda-files
   (quote
    ("/home/gonzz/MEGA/org/universidad.org" "/home/gonzz/MEGA/org/gestiones.org" "/home/gonzz/MEGA/org/ingles.org")))
 '(package-selected-packages
   (quote
    (doom-themes color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow magit dracula-theme emojify)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;me gusta más con 4 que con 8
(setq c-basic-offset 4) 

;; org-mode activation
(require 'org)
     (global-set-key "\C-cl" 'org-store-link)
     (global-set-key "\C-ca" 'org-agenda)
     (global-set-key "\C-cc" 'org-capture)
     (global-set-key "\C-cb" 'org-switchb)

;; para poner mis org files en la agenda
(setq org-agenda-files (list "~/MEGA/org/"))


;; para que el shift-tab tabule hacia atrás
(defun indent-region-custom(numSpaces)
    (progn 
        ; default to start and end of current line
        (setq regionStart (line-beginning-position))
        (setq regionEnd (line-end-position))

        ; if there's a selection, use that instead of the current line
        (when (use-region-p)
            (setq regionStart (region-beginning))
            (setq regionEnd (region-end))
        )

        (save-excursion ; restore the position afterwards            
            (goto-char regionStart) ; go to the start of region
            (setq start (line-beginning-position)) ; save the start of the line
            (goto-char regionEnd) ; go to the end of region
            (setq end (line-end-position)) ; save the end of the line

            (indent-rigidly start end numSpaces) ; indent between start and end
            (setq deactivate-mark nil) ; restore the selected region
        )
    )
)

(defun untab-region (N)
    (interactive "p")
    (indent-region-custom -4)
)

(defun tab-region (N)
    (interactive "p")
    (if (active-minibuffer-window)
        (minibuffer-complete)    ; tab is pressed in minibuffer window -> do completion
    ; else
    (if (string= (buffer-name) "*shell*")
        (comint-dynamic-complete) ; in a shell, use tab completion
    ; else
    (if (use-region-p)    ; tab is pressed is any other buffer -> execute with space insertion
        (indent-region-custom 4) ; region was selected, call indent-region
        (insert "    ") ; else insert four spaces as expected
    )))
)

(global-set-key (kbd "<backtab>") 'untab-region)
(global-set-key (kbd "<tab>") 'tab-region)

;;para añadir el tema de dracula
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)

;;para ver siempre el número de línea
(global-linum-mode t)

;;para indentar las macros como código normal
(c-set-offset (quote cpp-macro) 0 nil)

;;para que los backups se vayan a ~/.emacs-backups
(setq backup-directory-alist `(("." . "~/.emacs-backups")))

;;para usar C-<SCP> en vez de C-u C-<SPC> en las sucesivas invocaciones
;;del comando
(setq set-mark-command-repeat-pop t)

;;para que kills sucesivos no metan entradas iguales en el kill-ring, solo una de cada
(setq kill-do-not-save-duplicates t)

;;para que si usas C-v o M-v y ya has alcanzado el final mueva el puntero hasta el principio/final
(setq scroll-error-top-bottom t)

;;para que si haces scroll el puntero se quede en la posición de la pantalla nen la que estaba
(setq scroll-preserve-screen-position t)

;;para que cuando mueves el puntero fuera de la pantalla solo se mueva una línea cada vez
;;esto se consigue poniendo un número grande, de forma que nunca mueva el puntero al centro
(setq scroll-conservatively 200)

;;para que un scroll con el ratón mueva de una línea en una en vez de de 5 en 5
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))

;;para que aparezca la imagen de dio al iniciar emacs
;;(setq initial-buffer-choice "~/.dio.png")

;;to adjust the screen position
;;(setq default-frame-alist
;;      '((top . 0) (left . 0) (width . 0.5) (height 1.0)))       


;;to display the column number
(column-number-mode)

;;to set the tab width to 4
(setq tab-width 4)

;;to enable visual-line-mode in all buffers
(global-visual-line-mode)

;;to set de default column size of auto-fill-mode
(setq-default fill-column 100)

;;To set default font
(set-default-font "Hack 11")

;; To control opacity
 ;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
 ;;(set-frame-parameter (selected-frame) 'alpha <both>)
 (set-frame-parameter (selected-frame) 'alpha '(96 . 96))
 (add-to-list 'default-frame-alist '(alpha . (96 . 96)))

;; To install melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; To add emojify-mode globally
(add-hook 'after-init-hook #'global-emojify-mode)

;; An alias for the replace-string function (kudos to github.com/jlxip)
(defalias 'rs 'replace-string)
