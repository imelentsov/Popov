#!/usr/bin/python
# -*- coding: utf-8 -*-

from distutils.core import setup
from Cython.Build import cythonize
import sys

patterns = ['cio.pyx', 'file_encryptor.pyx']
if sys.argv[1] == "-c":
    patterns.append("madryga.pyx")
    sys.argv.remove("-c")

setup(
  name = 'Madryga',
  ext_modules = cythonize(patterns)
)