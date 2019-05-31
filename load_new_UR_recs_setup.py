from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("load_new_UR_recs.pyx"))

# complilation: python load_new_UR_recs_setup.py build_ext --inplace