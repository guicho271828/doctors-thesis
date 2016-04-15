(ql:quickload :alexandria)
(ql:quickload :eazy-gnuplot)
(use-package :alexandria)
(use-package :eazy-gnuplot)

(defparameter D 100.0)
(defvar w 2)

(defun n-zero (k &optional (d d) (w w))
  (float
   (loop with result = 1
         for l from 0 to k
         do (setf result (* result (- 1 (/ 1 (+ d (* (1- l) (1- w)))))))
         finally (return result))))

(defun pn-zero (k &optional (d d) (w w))
  (loop with result = d
        for l from 0 to k
        do (setf result (print (* result (- 1 (/ 1 (+ d (* (1- l) (1- w))))))))
        finally (return result)))

(with-plots (*standard-output*)
  (gp-setup :output "n-zero.pdf" :grid nil :samples 1000 :pointsize 0.3)
  (plot (lambda () (pn-zero 1000)))
  ;; (plot (format nil "100*(2**(-x/100))"))
  ;; (plot (format nil "100*(exp(-log(x)))"))
  (plot (format nil "100/exp(sqrt(x)/10000)"))
  ;; (plot (format nil "100-100*sqrt(x)"))
  )

