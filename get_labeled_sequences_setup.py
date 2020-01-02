from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("get_labeled_sequences.pyx"))

# complilation: python rget_labeled_sequences_setup.py build_ext --inplace