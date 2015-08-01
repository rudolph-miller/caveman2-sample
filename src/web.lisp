(in-package :cl-user)
(defpackage caveman2-sample.web
  (:import-from :alexandria
                :length=)
  (:use :cl
        :caveman2
        :caveman2-sample.config
        :caveman2-sample.view
        :caveman2-sample.db
        :integral
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

(defmacro defrender (name (&rest args) &body body)
  `(defun ,name (,@args)
     (let ((result (progn ,@body)))
       (apply #'render result))))

@route GET "/"
(defrender root ()
  nil)

;;
;; Error pages

(defmethod on-exception ((app <web>) (code (eql 404)))
  (declare (ignore app))
  (merge-pathnames #P"_errors/404.html"
                   *template-directory*))
