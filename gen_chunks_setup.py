from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("gen_chunks.pyx"))

# complilation: python gen_chunks_setup.py build_ext --inplace