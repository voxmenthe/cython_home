from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("loaddata_SUB_combo_new.pyx"))

# complilation: python loaddata_SUB_combo_new_setup.py build_ext --inplace