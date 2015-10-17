(cl:in-package #:vfile)

(defgeneric vfile-cwd (vfile))

(defgeneric (setf vfile-cwd) (vfile cwd))

(defgeneric vfile-base (vfile))

(defgeneric (setf vfile-base) (vfile base))

(defgeneric vfile-history (vfile))

(defgeneric (setf vfile-history) (vfile history))

(defgeneric vfile-contents (vfile))

(defgeneric (setf vfile-contents) (vfile contents))

(defgeneric vfile-dirname (vfile))

(defgeneric (setf vfile-dirname) (vfile dirname))

(defgeneric vfile-basename (vfile))

(defgeneric (setf vfile-basename) (vfile basename))

(defgeneric vfile-extname (vfile))

(defgeneric (setf vfile-extname) (vfile extname))

(defgeneric vfile-path (vfile))

(defgeneric (setf vfile-path) (vfile path))

(defgeneric vfile-relative (vfile))

(defgeneric vfile-open (vfile &key direction))

(defgeneric contents-input-stream (contents))

(defgeneric contents-output-stream (contents))

(defgeneric contents-io-stream (contents))

