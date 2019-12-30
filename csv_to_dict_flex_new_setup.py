from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("csv_to_dict_flex_new.pyx"))

# complilation: python csv_to_dict_flex_new_setup.py build_ext --inplace