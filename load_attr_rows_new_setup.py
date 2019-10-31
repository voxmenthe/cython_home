from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("load_attr_rows_new.pyx"))

# complilation: python load_attr_rows_new_setup.py build_ext --inplace