from libc.math cimport sqrt
import numpy as np
cimport numpy as np

def cy_cosine(np.ndarray[np.float64_t] x, np.ndarray[np.float64_t] y):
    cdef double xx=0.0
    cdef double yy=0.0
    cdef double xy=0.0
    cdef Py_ssize_t i
    for i in range(len(x)):
        xx+=x[i]*x[i]
        yy+=y[i]*y[i]
        xy+=x[i]*y[i]
    return xy/sqrt(xx*yy)