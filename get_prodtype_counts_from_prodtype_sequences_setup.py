from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("get_prodtype_counts_from_prodtype_sequences.pyx"))

# complilation: python rget_prodtype_counts_from_prodtype_sequences_setup.py build_ext --inplace