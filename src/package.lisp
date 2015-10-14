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
           #:vfile-buffer-p
           #:vfile-stream-p
           #:vfile-pathname-p
           #:vfile-null-p
           #:vfile-directory-p
           #:vfile-open
           #:vfile))
