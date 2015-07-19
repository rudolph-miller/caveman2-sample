(in-package :cl-user)
(defpackage caveman2-sample.db
  (:use :cl)
  (:import-from :caveman2-sample.config
                :config)
  (:import-from :integral
                :connect-toplevel)
  (:export :connection-settings
           :db
           :with-connection))
(in-package :caveman2-sample.db)

(defun connection-settings (&optional (db :maindb))
  (cdr (assoc db (config :databases))))


(apply #'connect-toplevel (connection-settings))
