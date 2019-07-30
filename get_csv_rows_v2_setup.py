from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("get_csv_rows_v2.pyx"))

# complilation: python get_csv_rows_v2_setup.py build_ext --inplace