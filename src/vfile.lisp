(cl:in-package #:vfile)

(defclass vfile ()
  ((%cwd
     :initarg :cwd
     :accessor vfile-cwd
     :initform (getcwd))
   (%base
     :initarg :base
     :accessor vfile-base
     :initform nil)
   (%path
     :initarg :path
     :accessor vfile-path
     :initform nil)
   (%contents
     :initarg :contents
     :accessor vfile-contents
     :initform nil)))

(defmethod print-object ((f vfile) stream)
  (format stream "#<~A ~S ~S>"
      (class-name (class-of f))
	  (if (and (vfile-base f) (vfile-path f))
	      (vfile-relative f)
	      (vfile-path f))
	  (vfile-contents f))
  f)

(defmethod file-dirname ((f vfile))
  (unless (vfile-path f)
    (error "No path specified, cannot get dirname."))
  (dirname (vfile-path f)))

(defmethod (setf vfile-dirname) ((f vfile) dirname)
  (unless (vfile-path f)
    (error "No path specified, cannot set dirname."))
  (setf (vfile-path f)
        (join dirname (basename (vfile-path f)))))

(defmethod vfile-basename ((f vfile))
  (unless (vfile-path f)
    (error "No path specified, cannot get basename."))
  (basename (vfile-path f)))

(defmethod (setf vfile-basename) ((f vfile) basename)
  (unless (vfile-path f)
    (error "No path specified, cannot getset basename."))
  (setf (vfile-path f)
        (join (dirname (vfile-path f)) basename)))

(defmethod vfile-extname ((f vfile))
  (unless (vfile-path f)
    (error "No path specified, cannot get extname."))
  (extname (vfile-path f)))

(defmethod (setf vfile-extname) ((f vfile) extname)
  (unless (vfile-path f)
    (error "No path specified, cannot set extname."))
  (setf (vfile-path f) (replace-ext (file-path f) extname)))

(defmethod vfile-relative ((f vfile))
  (unless (vfile-base f)
    (error "No base specified, cannot get relative."))
  (unless (vfile-path f)
    (error "No path specified, cannot get relative."))
  (relative (vfile-base f) (vfile-path f)))

(defmethod vfile-open ((f vfile) &key (direction :input))
  (cond
    ((eq direction :input)
     (contents-input-stream (vfile-contents f)))
    ((eq direction :output)
     (contents-output-stream (vfile-contents f)))
    ((eq direction :io)
     (contents-io-stream (vfile-contents f)))))

;;; stream methods for vector, stream, pathname, and null

(defmethod contents-input-stream ((contents vector))
  (make-instance 'fast-input-stream
                 :vector contents))

(defmethod contents-input-stream ((contents stream))
  contents)

(defmethod contents-input-stream ((contents pathname))
  (if (directory-exists-p contents)
      (make-instance 'fast-input-stream)
      (open contents :direction :input :element-type '(unsigned-byte 8))))

(defmethod contents-input-stream ((contents null))
  (make-instance 'fast-input-stream))
