(cl:in-package #:cl-user)

(defpackage #:vfile
  (:use #:cl)
  (:import-from #:fast-io
                #:fast-input-stream)
  (:import-from #:path-string
                #:dirname
                #:join
                #:basename
                #:extname
                #:relative)
  (:import-from #:uiop
		#:directory-exists-p
                #:getcwd)
  (:export #:vfile-cwd
           #:vfile-base
           #:vfile-history
           #:vfile-contents
           #:vfile-dirname
           #:vfile-basename
           #:vfile-extname
           #:vfile-path
           #:vfile-relative
           #:vfile-open
           #:with-open-vfile
           #:contents-input-stream
           #:contents-output-stream
           #:contents-io-stream
           #:vfile))
