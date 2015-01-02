@echo off
::gcc madryga_cipher.c -c -S -m32 -o madryga_cipher.S
SetLocal enabledelayedexpansion

if "%1"=="-c" goto compile_c
    echo compiling from asm code
    setup.py build_ext --inplace

    C:\Python34\Lib\site-packages\Cython-0.21.1-py3.4-win32.egg\cython.py  madryga.pyx
    
    C:\MinGW\bin\gcc.exe -mdll -O -Wall -IC:\Python34\include -IC:\Python34\include -c madryga.c -o build\temp.win32-3.4\Release\madryga.o
    gcc.exe -mdll -O -Wall -IC:\Python34\include -IC:\Python34\include -c madryga_cipher.S -o build\temp.win32-3.4\Release\madryga_cipher.o

    echo LIBRARY madryga.pyd > build\temp.win32-3.4\Release\madryga.def
    echo.EXPORTS >> build\temp.win32-3.4\Release\madryga.def
    echo.PyInit_madryga >> build\temp.win32-3.4\Release\madryga.def
    
    gcc.exe -shared -s build\temp.win32-3.4\Release\madryga.o build\temp.win32-3.4\Release\madryga_cipher.o build\temp.win32-3.4\Release\madryga.def -LC:\Python34\libs -LC:\Python34\PCbuild -lpython34 -lmsvcr100 -o madryga.pyd
    GOTO :EOF

:compile_c
    echo compiling from c code
    setup.py -c build_ext --inplace
EndLocal