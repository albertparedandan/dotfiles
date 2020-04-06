;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Albert Paredandan"
      user-mail-address "albertparedandan@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Make doom always start full-screen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Enable date view in modeline
(setq display-time-day-and-date t)

;; Disable load average in modeline
(setq display-time-default-load-average nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; ORG-MODE SETTINGS

;;;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org-mode")

;;;; turn on org-mode log done todo
(setq org-log-done t)

;;;; Keybindings for org-mode
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

;; Org-agenda files
(setq org-agenda-files (list "~/org-mode/To-Do/2020-todo.org"))

(after! org
  ;; modifies org-todo keywords
  (setq org-todo-keywords
        '(
          (sequence "TODO(t)" "WAITING(w)" "COMING(c)" "|" "DONE(d)" "CANCELED(x)")
          )
        )

  ;; changes the org-todo keyword faces
  (setq org-todo-keyword-faces
        '(
          ("COMING" . (:foreground "#ff5555" :weight bold))
          ("WAITING" . "#8be9fd")
          ("DONE" . (:foreground "#565761" :weight bold))
          ("CANCELED" . (:foreground "#565761" :weight bold))
          )
        )

  ;; modifies the default dictionary on org-mode
  (setq ispell-dictionary "british")

  ;; change default org-archive to make the archive files neater
  (setq org-archive-default-command #'org-archive-subtree-hierarchically)

  (defun org-archive-subtree-hierarchically (&optional prefix)
    (interactive "P")
    (let* ((fix-archive-p (and (not prefix)
                               (not (use-region-p))))
           (afile  (car (org-archive--compute-location
                         (or (org-entry-get nil "ARCHIVE" 'inherit) org-archive-location))))
           (buffer (or (find-buffer-visiting afile) (find-file-noselect afile))))
      (org-archive-subtree prefix)
      (when fix-archive-p
        (with-current-buffer buffer
          (goto-char (point-max))
          (while (org-up-heading-safe))
          (let* ((olpath (org-entry-get (point) "ARCHIVE_OLPATH"))
                 (path (and olpath (split-string olpath "/")))
                 (level 1)
                 tree-text)
            (when olpath
              (org-mark-subtree)
              (setq tree-text (buffer-substring (region-beginning) (region-end)))
              (let (this-command (inhibit-message t)) (org-cut-subtree)) ; we don’t want to see "Cut subtree" messages
              (goto-char (point-min))
              (save-restriction
                (widen)
                (-each path
                  (lambda (heading)
                    (if (re-search-forward
                         (rx-to-string
                          `(: bol (repeat ,level "*") (1+ " ") ,heading)) nil t)
                        (org-narrow-to-subtree)
                      (goto-char (point-max))
                      (unless (looking-at "^")
                        (insert "\n"))
                      (insert (make-string level ?*)
                              " "
                              heading
                              "\n"))
                    (cl-incf level)))
                (widen)
                (org-end-of-subtree t t)
                (org-paste-subtree level tree-text))))))))

  ;; change custom key chords for org-archive-default
  (define-key global-map "\C-cd" 'org-archive-subtree-default)

  ;; export org-files to a folder
  ;; TODO dynamically change the beginning of the folder name to "parent's name + export files"
  (defun org-export-output-file-name-modified (orig-fun extension &optional subtreep pub-dir)
    (unless pub-dir
      (setq pub-dir "exported-org-files")
      (unless (file-directory-p pub-dir)
        (make-directory pub-dir)))
    (apply orig-fun extension subtreep pub-dir nil))
  (advice-add 'org-export-output-file-name :around #'org-export-output-file-name-modified)

  ;; put log notes into drawers in org=mode
  (setq org-log-into-drawer 't)
)
