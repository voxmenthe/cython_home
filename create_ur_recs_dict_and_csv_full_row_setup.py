from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("create_ur_recs_dict_and_csv_full_row.pyx"))

# complilation: python create_ur_recs_dict_and_csv_full_row_setup.py build_ext --inplace