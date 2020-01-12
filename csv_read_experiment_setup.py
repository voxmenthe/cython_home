from distutils.core import setup
from Cython.Build import cythonize
import numpy

setup(ext_modules=cythonize("csv_read_experiment*.pyx"),
	include_dirs=[numpy.get_include()])

# complilation: python csv_read_experiment_setup.py build_ext --inplace