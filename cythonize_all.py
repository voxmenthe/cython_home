from distutils.core import setup  
from Cython.Build import cythonize  
setup(ext_modules = cythonize("*.pyx", annotate=True))

# to use: python cythonize_all.py build_ext --inplace