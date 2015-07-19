(in-package :cl-user)
(defpackage caveman2-sample-asd
  (:use :cl :asdf))
(in-package :caveman2-sample-asd)

(defsystem caveman2-sample
  :version "0.1"
  :author "Rudolph Miller"
  :license "MIT"
  :depends-on (:clack
               :lack
               :caveman2
               :envy
               :cl-ppcre

               ;; for @route annotation
               :cl-syntax-annot

               ;; HTML Template
               :djula

               ;; for DB
               :integral
               :sxql

               :alexandria)
  :components ((:module "src"
                :components
                ((:file "main" :depends-on ("config" "view" "db"))
                 (:file "web" :depends-on ("view"))
                 (:file "view" :depends-on ("config"))
                 (:file "db" :depends-on ("config"))
                 (:file "config"))))
  :description ""
  :in-order-to ((test-op (load-op caveman2-sample-test))))
