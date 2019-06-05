from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("loaddata_SUB_from_rows.pyx"))