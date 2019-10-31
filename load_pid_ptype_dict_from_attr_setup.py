from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("load_pid_ptype_dict_from_attr.pyx"))

# complilation: python load_pid_ptype_dict_from_attr_setup.py build_ext --inplace