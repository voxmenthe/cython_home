from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("read_csv_events_to_dict.pyx"))

# complilation: python read_csv_events_to_dict_setup.py build_ext --inplace