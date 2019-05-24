from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("loaddata_PID.pyx"))

# complilation: python loaddata_PID_setup.py build_ext --inplace