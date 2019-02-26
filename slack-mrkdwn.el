;;; slack-mrkdwn.el ---                              -*- lexical-binding: t; -*-

;; Copyright (C) 2019

;; Author:  <yuya373@archlinux>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:
(require 'slack-util)

(defconst slack-mrkdwn-regex-bold
  "\\(?:^\\|[^\\]\\)\\(\\(*\\)\\([^ \n\t\\]\\|[^ \n\t*]\\(?:.\\|\n[^\n]\\)*?[^\\ ]\\)\\(\\2\\)\\)")

(defface slack-mrkdwn-bold-face
  '((t (:weight bold)))
  "Face used to between `*'"
  :group 'slack)

(defconst slack-mrkdwn-regex-italy
  "\\(?:^\\|[^\\]\\)\\(\\(_\\)\\([^ \n\t\\]\\|[^ \n\t*]\\(?:.\\|\n[^\n]\\)*?[^\\ ]\\)\\(\\2\\)\\)")

(defconst slack-mrkdwn-regex-strike
  "\\(?:^\\|[^\\]\\)\\(\\(~\\)\\([^ \n\t\\]\\|[^ \n\t*]\\(?:.\\|\n[^\n]\\)*?[^\\ ]\\)\\(\\2\\)\\)")

(defconst slack-mrkdwn-regex-code
  "\\(?:\\`\\|[^\\]\\)\\(\\(`\\)\\(\\(?:.\\|\n[^\n]\\)*?[^`]\\)\\(\\2\\)\\)\\(?:[^`]\\|\\'\\)")

(defconst slack-mrkdwn-regex-code-block "\\(```\\)\\(\\(.\\|\n\\)*?\\)\\(```\\)")

(defun slack-mrkdwn-add-face ()
  (slack-mrkdwn-add-bold-face)
  )

(defun slack-mrkdwn-add-bold-face ()
  (goto-char (point-min))
  (while (re-search-forward slack-mrkdwn-regex-bold (point-max) t)
    (slack-if-let* ((beg (match-beginning 3))
                    (end (match-end 3)))
        (progn
          (put-text-property beg end 'face 'slack-mrkdwn-bold-face)
          (slack-if-let* ((markup-start-beg (match-beginning 2))
                          (markup-start-end (match-end 2)))
              (put-text-property markup-start-beg
                                 markup-start-end
                                 'invisible t))
          (slack-if-let* ((markup-end-beg (match-beginning 4))
                          (markup-end-end (match-end 4)))
              (put-text-property markup-end-beg
                                 markup-end-end
                                 'invisible t))))))

(provide 'slack-mrkdwn)
;;; slack-mrkdwn.el ends here
