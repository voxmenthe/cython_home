from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("get_ptype_cts_IA_from_ptype_seqs_2_new.pyx"))

# complilation: python get_ptype_cts_IA_from_ptype_seqs_2_new_setup.py build_ext --inplace