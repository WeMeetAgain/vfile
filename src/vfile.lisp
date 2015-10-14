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
   (%history
     :initarg :history
     :accessor vfile-history
     :initform nil)
   (%directory-p
     :initarg :directory-p
     :accessor vfile-directory-p
     :initform nil)
   (%contents
     :initarg :contents
     :reader vfile-contents
     :initform nil)))

(defmethod print-object ((f vfile) stream)
  (format stream "#<VFILE ~S ~S>"
	  (if (and (vfile-base f) (vfile-path f))
	      (vfile-relative f)
	      (vfile-path f))
	  (vfile-contents f))
  f)

(defmethod (setf vfile-contents) ((f vfile) contents)
  (when (and (not (buffer-p contents))
             (not (streamp contents))
             (not (pathnamep contents))
             (not (null contents)))
    (error "Contents can only be a buffer, stream, pathname, or nil"))
  (setf (slot-value f '%contents) contents))

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

(defmethod vfile-path ((f vfile))
  (first (vfile-history f)))

(defmethod (setf vfile-path) ((f vfile) (path string))
  (push path (vfile-history f)))

(defmethod vfile-relative ((f vfile))
  (unless (vfile-base f)
    (error "No base specified, cannot get relative."))
  (unless (vfile-path f)
    (error "No path specified, cannot get relative."))
  (relative (vfile-base f) (vfile-path f)))

(defmethod vfile-buffer-p ((f vfile))
  (buffer-p (vfile-contents f)))

(defmethod vfile-stream-p ((f vfile))
  (streamp (vfile-contents f)))

(defmethod vfile-pathname-p ((f vfile))
  (pathnamep (vfile-contents f)))

(defmethod vfile-null-p ((f vfile))
  (null (vfile-contents f)))

(defmethod vfile-open ((f vfile) &rest rest)
  (cond
    ((vfile-directory-p f)
     (make-string-input-stream ""))
    ((vfile-buffer-p f)
     (make-instance 'fast-input-stream
                    :vector (vfile-contents f)))
    ((vfile-stream-p f)
     (vfile-contents f))
    ((vfile-pathname-p f) 
     (apply #'open (vfile-contents f) rest))
    ((vfile-null-p f)
     (make-string-input-stream ""))))
