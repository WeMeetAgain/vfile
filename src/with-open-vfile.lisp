(cl:in-package :vfile)

;;; adapted from https://github.com/robert-strandh/SICL/blob/master/Code/Stream/with-open-stream-defmacro.lisp
(defmacro with-open-vfile ((stream vfile) &body body)
  (multiple-value-bind (declarations forms)
      (let ((pos (position-if-not (lambda (item)
				    (and (consp item)
					 (eq (car item) 'declare)))
				  body)))
	(if (null pos)
	    (values body '())
	    (values (subseq body 0 pos) (subseq body pos))))
    `(let ((,stream (vfile-open ,vfile)))
       ,@declarations
       (unwind-protect (progn ,@forms)
	 (close ,stream)))))

