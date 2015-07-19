(in-package :cl-user)
(defpackage caveman2-sample.view
  (:use :cl)
  (:import-from :caveman2-sample.config
                :*template-directory*)
  (:import-from :caveman2
                :*response*
                :response-headers
                :throw-code)
  (:import-from :djula
                :add-template-directory
                :compile-template*
                :render-template*
                :*djula-execute-package*)
  (:import-from :datafly
                :encode-json)
  (:export :*current-template*
           :render
           :render-json))
(in-package :caveman2-sample.view)

(djula:add-template-directory *template-directory*)

(defparameter *template-registry* (make-hash-table :test 'equal))

(defparameter *current-template* nil)

(defun render (&optional env)
  (if (probe-file (merge-pathnames *template-directory* *current-template*))
      (apply #'djula:render-template* *current-template* nil env)
      (throw-code 404)))

(defun render-json (object)
  (setf (getf (response-headers *response*) :content-type) "application/json")
  (encode-json object))


;;
;; Execute package definition

(defpackage caveman2-sample.djula
  (:use :cl)
  (:import-from :caveman2-sample.config
                :config
                :appenv
                :developmentp
                :productionp)
  (:import-from :caveman2
                :url-for))

(setf djula:*djula-execute-package* (find-package :caveman2-sample.djula))
