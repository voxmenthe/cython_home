from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("load_P_recs.pyx"))

# complilation: python load_csv_delims_setup.py build_ext --inplace