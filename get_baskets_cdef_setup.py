from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("get_baskets_cdef.pyx"))