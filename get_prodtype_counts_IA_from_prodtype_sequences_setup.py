from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("get_prodtype_counts_IA_from_prodtype_sequences.pyx"))

# complilation: python get_prodtype_counts_IA_from_prodtype_sequences_setup.py build_ext --inplace