from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("get_csv_rows.pyx"))

# complilation: python get_csv_rows_setup.py build_ext --inplace