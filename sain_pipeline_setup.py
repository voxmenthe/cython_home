from distutils.core import setup
from Cython.Build import cythonize
setup(ext_modules=cythonize("sain_pipeline.pyx"))

# complilation: python sain_pipeline_setup.py build_ext --inplace