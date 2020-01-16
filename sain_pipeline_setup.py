import numpy
from distutils.core import setup
from Cython.Build import cythonize

setup(ext_modules=cythonize("sain_pipeline.pyx"),
	include_dirs=[numpy.get_include()])

# complilation: python sain_pipeline_setup.py build_ext --inplace