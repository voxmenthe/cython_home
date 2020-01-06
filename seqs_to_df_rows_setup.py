from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("seqs_to_df_rows.pyx"))

# complilation: python seqs_to_df_rows_setup.py build_ext --inplace