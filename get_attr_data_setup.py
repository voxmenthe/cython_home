from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("get_attr_data.pyx"))

# to run: python get_attr_data_setup.py build_ext --inplace