from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("load_attr_rows_basic.pyx"))

# complilation: python load_attr_rows_basic_setup.py build_ext --inplace