(cl:in-package #:vfile)

;;; A vfile, or virtual file, is a file metadata object that provides a
;;; file-like interface to some file contents as a stream of
;;; `(unsigned byte 8)` elements.

;;; A vfile consists of:
;;;  - cwd - a current working directory
;;;  - base - a path used for relative pathing
;;;  - path - the full path string of the file
;;;  - contents - the file contents

;;; cwd

(defgeneric vfile-cwd (vfile))

(defgeneric (setf vfile-cwd) (vfile cwd))

;;; base

(defgeneric vfile-base (vfile))

(defgeneric (setf vfile-base) (vfile base))

;;; path accessors

;;; These functions are based off of corresponding functions in the
;;; path-string package, which is based off of the node.js path library.

(defgeneric vfile-path (vfile))

(defgeneric (setf vfile-path) (vfile path))

(defgeneric vfile-dirname (vfile))

(defgeneric (setf vfile-dirname) (vfile dirname))

(defgeneric vfile-basename (vfile))

(defgeneric (setf vfile-basename) (vfile basename))

(defgeneric vfile-extname (vfile))

(defgeneric (setf vfile-extname) (vfile extname))

(defgeneric vfile-relative (vfile))

;;; contents

(defgeneric vfile-contents (vfile))

(defgeneric (setf vfile-contents) (vfile contents))

;;; open

;;; vfile-open returns a stream representation of VFILE in the same style as
;;; cl:open does with pathnames.
(defgeneric vfile-open (vfile &key direction &allow-other-keys))

(defgeneric contents-input-stream (contents))

(defgeneric contents-output-stream (contents))

(defgeneric contents-io-stream (contents))

