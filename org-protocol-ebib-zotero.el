;;; ebib-biblio.el --- Part of Ebib, a BibTeX database manager  -*- lexical-binding: t -*-

;; Copyright (c) 2022 Grzegorz Kowzan
;; All rights reserved.

;; Author: Grzegorz Kowzan <grzegorz@kowzan.eu>
;; Maintainer: Joost Kremers <joostkremers@fastmail.fm>

;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;;
;; 1. Redistributions of source code must retain the above copyright
;;    notice, this list of conditions and the following disclaimer.
;; 2. Redistributions in binary form must reproduce the above copyright
;;    notice, this list of conditions and the following disclaimer in the
;;    documentation and/or other materials provided with the distribution.
;; 3. The name of the author may not be used to endorse or promote products
;;    derived from this software without specific prior written permission.
;;
;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
;; IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
;; OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
;; IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
;; INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
;; NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES ; LOSS OF USE,
;; DATA, OR PROFITS ; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
;; THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;;; Commentary:

;; This file is part of Ebib, a BibTeX database manager for Emacs. It provides
;; an `org-protocol' handler that will import the bibliographic record
;; associated with the provided URL into ebib database. To use it, add (require
;; 'org-protocol-ebib-zotero) to init.el file. It also requires a running
;; instance of Zotero translation server to work. Refer to [biblio] or [zotero]
;; for details.
;;
;; [biblio]: https://github.com/cpitclaudel/biblio.el
;; [zotero]: https://github.com/zotero/translation-server

;;; Code:

(require 'org-protocol)
(require 'ebib-biblio)

(defun ebib-zotero-protocol-handler (info)
  "Process an org-protocol://ebib-zotero?href= style url with INFO.

Calls `ebib-biblio-import-zotero' with the provided URI to add a
new BibTeX entry to the current database.

Add the following as a browser bookmark to use:

    javascript:location.href = \\='org-protocol://ebib-zotero?href=\\='+ \\
            encodeURIComponent(location.href)"
  (unless (plist-get info :href)
    (user-error "No URI provided"))
  (ebib-biblio-import-zotero (plist-get info :href)))

(push '("ebib-zotero" :protocol "ebib-zotero" :function ebib-zotero-protocol-handler)
      org-protocol-protocol-alist)

(provide 'org-protocol-ebib-zotero)
;;; org-protocol-ebib-zotero.el ends here
