from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("loaddata_PID_cyth_new_setup.pyx"))

# complilation: python csv_event_rows_to_dict_setup.py build_ext --inplace