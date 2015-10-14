(cl:in-package #:vfile)

(defun replace-ext (path new-ext)
  (let ((new-ext (if (char= (aref new-ext 0) #\.)
                   new-ext
                   (format nil ".~A" new-ext))))
    (multiple-value-bind (root dir base ext name)
        (parse path)
      (declare (ignore root base))
      (concatenate 'string
                   dir "/" name new-ext))))

(defun buffer-p (obj)
  (typecase obj
    ((vector (unsigned-byte 8)) t)
    (otherwise nil)))
