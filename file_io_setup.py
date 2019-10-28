from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("file_io.pyx"))
# complilation: python file_io_setup.py build_ext --inplace