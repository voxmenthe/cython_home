from distutils.core import setup
from Cython.Build import cythonize
import numpy
setup(
    ext_modules = cythonize("cy_cos_sim.pyx"),
    include_dirs=[numpy.get_include(),numpy.linalg.get_include()]
)