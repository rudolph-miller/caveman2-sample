(in-package :cl-user)
(defpackage caveman2-sample-test-asd
  (:use :cl :asdf))
(in-package :caveman2-sample-test-asd)

(defsystem caveman2-sample-test
  :author "Rudolph Miller"
  :license "MIT"
  :depends-on (:caveman2-sample
               :prove)
  :components ((:module "t"
                :components
                ((:file "caveman2-sample"))))
  :perform (load-op :after (op c) (asdf:clear-system c)))
