from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("read_csv_events_to_one_prodtype_sequence.pyx"))

# complilation: python read_csv_events_to_one_prodtype_sequence_setup.py build_ext --inplace