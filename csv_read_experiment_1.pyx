
@cython.boundscheck(False)
@cython.wraparound(False)
cdef inline int fast_atoi(char *buf, int size):
    cdef int i=0 ,c = 0, sign = 0, x = 0
    for i in range(size):
        c = buf[i]
        if c == 0:
            break
        if c == 45:
            sign = 1
        elif c > 47 and c < 58:
            x = x * 10 + c - 48
    return -x if sign else x

@cython.boundscheck(False)
@cython.wraparound(False)
def fastest_read_points(fn):
    cdef bytes buf
    with open(fn, "rb") as f:
        buf = f.read().replace(b"\n", b"") # change it with your endline.

    cdef char * p = buf
    cdef int length = len(buf)
    cdef char * buf_end = p + length
    cdef int count = length // 16 * 2 # create enough large array  
    cdef int[:, ::1] res = np.zeros((count, 3), np.int32)
    cdef int i, j, block_count
    i = 0
    while p < buf_end:
        block_count = fast_atoi(p, 10)
        p += 10
        for j in range(block_count):
            res[i, 0] = fast_atoi(p, 6)
            res[i, 1] = fast_atoi(p+6, 6)
            res[i, 2] = fast_atoi(p+12, 4)
            p += 16
            i += 1
    return res.base[:i]