(in-package :cl-user)
(defpackage caveman2-sample.web
  (:import-from :alexandria
                :length=)
  (:use :cl
        :caveman2
        :caveman2-sample.config
        :caveman2-sample.view
        :caveman2-sample.db
        :datafly
        :sxql)
  (:export :*web*))
(in-package :caveman2-sample.web)

;; for @route annotation
(syntax:use-syntax :annot)

;;
;; Application

(defclass <web> (<app>) ())

(defmethod lack.component:call :around ((self <web>) env)
  (let ((path (getf env :path-info)))
    (when (char= (char path 0) #\/)
      (setq path (subseq path 1)))
    (when (length= path 0)
      (setq path "index"))
  (let ((*current-template* (concatenate 'string path ".html")))
    (call-next-method))))

(defvar *web* (make-instance '<web>))
(clear-routing-rules *web*)

;;
;; Routing rules

@route GET "/"
(defun root ()
  (render))

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
