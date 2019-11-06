from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("events_to_rows.pyx"))

# complilation: python events_to_rows_setup.py build_ext --inplace