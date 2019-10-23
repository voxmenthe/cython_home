from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("csv_event_rows_to_dict.pyx"))

# complilation: python csv_event_rows_to_dict.pyx build_ext --inplace