from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("loaddata_PID_by_x.pyx"))

# complilation: python loaddata_PID_by_x_setup.py build_ext --inplace