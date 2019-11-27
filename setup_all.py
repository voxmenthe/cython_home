from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("*.pyx"))

# complilation: python setup_all.py build_ext --inplace