(cl:in-package #:asdf-user)

(defsystem :vfile
  :version "0.1.0"
  :description "A simple virtual file"
  :author "Cayman Nava"
  :license "MIT"
  :depends-on (:fast-io :path-string)
  :components ((:module "src"
        :serial t
		:components
		((:file "package")
		 (:file "interface")
		 (:file "util")
		 (:file "vfile")
		 (:file "with-open-vfile"))))
  :long-description #.(uiop:read-file-string
		       (uiop:subpathname *load-pathname* "README.md"))
  :in-order-to ((test-op (test-op vfile-test))))
		 
