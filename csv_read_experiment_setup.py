from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("csv_read_experiment*.pyx"))

# complilation: python csv_read_experiment_setup.py build_ext --inplace