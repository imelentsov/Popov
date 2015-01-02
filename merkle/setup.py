#!/usr/bin/python
# -*- coding: utf-8 -*-

from distutils.core import setup
from Cython.Build import cythonize

setup(
  name = 'Madryga',
  ext_modules = cythonize('*.pyx')
)