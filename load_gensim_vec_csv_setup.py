from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("load_gensim_vec_csv.pyx"))

# to run: python load_gensim_vec_csv_setup.py build_ext --inplace