from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("loaddata_PID_cyth_new.pyx"))

# complilation: python loaddata_PID_cyth_new_setup.py build_ext --inplace