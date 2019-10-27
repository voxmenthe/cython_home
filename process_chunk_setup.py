from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("process_chunk.pyx"))

# complilation: python process_chunk_setup.py build_ext --inplace