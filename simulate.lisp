

(ql:quickload :alexandria)
(ql:quickload :eazy-gnuplot)
(ql:quickload :iterate)
(use-package :alexandria)
(use-package :eazy-gnuplot)
(use-package :iterate)

(defun aarray ()
  (make-array '(0) :adjustable t :fill-pointer 0))

(defun simulate (d w c)
  "number of elements in each bucket"
  (let ((buckets (aarray)))
    (vector-push-extend d buckets 1)
    (iter (repeat c)
          (let ((selected (select-index buckets)))
            (decf (aref buckets selected))
            (unless (< (1+ selected) (length buckets))
              (vector-push-extend 0 buckets 1)
              (print buckets))
            (incf (aref buckets (1+ selected)) w)))
    buckets))

(defun simulate (d w c)
  "number of cumulative number of nodes in each bucket" 
  (let ((buckets (aarray))
        (cumulative (aarray)))
    (vector-push-extend d buckets 1)
    (vector-push-extend d cumulative 1)
    (iter (repeat c)
          (let ((selected (select-index buckets)))
            (decf (aref buckets selected))
            (unless (< (1+ selected) (length buckets))
              (vector-push-extend 0 buckets 1)
              (vector-push-extend 0 cumulative 1)
              (print buckets))
            (incf (aref buckets (1+ selected)) w)
            (incf (aref cumulative (1+ selected)) w)))
    cumulative))

(defun simulate (d w c)
  "number of cumulative number of expansions in each bucket"
  (let ((buckets (aarray))
        (expansions (aarray)))
    (vector-push-extend d buckets 1)
    (vector-push-extend 0 expansions 1)
    (iter (repeat c)
          (let ((selected (select-index buckets)))
            (decf (aref buckets selected))
            (unless (< (1+ selected) (length buckets))
              (vector-push-extend 0 buckets 1)
              (vector-push-extend 0 expansions 1)
              (print buckets))
            (incf (aref buckets (1+ selected)) w)
            (incf (aref expansions selected))))
    expansions))

(defun simulate (d w c)
  "probability of each node to be expanded" 
  (let ((buckets (aarray))
        (cumulative (aarray))
        (expansions (aarray)))
    (vector-push-extend d buckets 1)
    (vector-push-extend d cumulative 1)
    (vector-push-extend 0 expansions 1)
    (iter (repeat c)
          (let ((selected (select-index buckets)))
            (decf (aref buckets selected))
            (unless (< (1+ selected) (length buckets))
              (vector-push-extend 0 buckets 1)
              (vector-push-extend 0 cumulative 1)
              (vector-push-extend 0 expansions 1)
              (print buckets))
            (incf (aref buckets (1+ selected)) w)
            (incf (aref cumulative (1+ selected)) w)
            (incf (aref expansions selected))))
    (map 'vector (lambda (exp nodes)
                   ;; (print (list exp nodes) *error-output*)
                   (float (/ exp nodes))) expansions cumulative)))


(defun select-index (buckets)
  (iter outer
        (generate c from 1)
        (with selected = 0)
        (for index below (length buckets))
        (iter (for counter below (aref buckets index))
              (in outer (next c))
              (when (< (random 1.0) (/ 1 c))
                (setf selected index)))
        (finally
         (return-from outer selected))))

(defun select-index (buckets)
  (let ((acc (copy-array buckets)))
    (iter (for num in-vector acc with-index i)
          (when (first-iteration-p) (next-iteration))
          (incf (aref acc i) (aref acc (1- i))))
    (let ((sum (aref acc (1- (length acc)))))
      (let ((sample (random sum)))
        (iter (for num in-vector acc with-index i)
              (finding i such-that (<= sample num)))))))

(progn
  (defun plot-simulations ()
    (with-plots (*standard-output*)
      (gp-setup :output "simulate.pdf" :grid nil :samples 1000 :pointsize 0.3 ; :logscale :y
                :key :off
                :xrange '|[0:14]|
                ;; :key '(:font "Times New Roman, 11pt")
                )
      (iter (for d in '(5))
            (iter (for w in '(30))
                  (iter (for c from 20000 below 20000 by 20000)
                        (iter (repeat 100)
                              (plot (lambda ()
                                      (map nil #'print (simulate (expt 10 d) w c)))
                                    :title (format nil "d=~e, w=~a, c=~e" (expt 10 d) w c)
                                    :with :lines)))))))
  (plot-simulations))

#+test
(let ((result (iter (repeat 10000)
                    (collect (select-index #(8 4 2 1))))))
  (iter (for i below 4)
        (collecting (funcall #'count i result))))


#+test
(simulate 10000 2 1000)
