from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("create_ur_recs.pyx"))

# complilation: python create_ur_recs_setup.py build_ext --inplace