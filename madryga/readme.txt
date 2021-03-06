﻿Выполнил: Меленцов Иван
Группа: КБ-501
Задачи: 1 - Реализовать алгоритм шифрования и дешифрования, 11 - Реализовать криптоалгоритм на ассемблере с закладкой

Описание алгоритма шифрование Madryga:
    1) Madryga состоит из двух вложенных циклов. Внешний цикл имеет 8 итераций (число итераций может изменено).
    2) Внутринний цикл оперирует 3-байтовым окном и проходит по всем байтам блока шифрования
    3) Блок шифрования имеет переменную длину
    4) Блок данных считается циклически замкнутым
    5) На каждом шаге внутреннего выполняется следующие:
        I) Младшие 3 бита, младшего байта, определяют циклический сдвиг влево оставшихся 2 байт окна
        II) В целях превращения ключа в псевдослучайную последовательность, выполняется XOR с некой константой 
              (для 64-битного ключа рекомендуется использовать 0x0f1e2d3c4b5a6978) и сдвиг на 3 влево 
        III) Младший байт XOR-ится с подготовленным ключом


Описание работы "закладки":
    В режиме закладки алгоритм шифрования игнорирует ключ, осуществляя лишь перемешивания открытого текста.
    Скрытность закладки: 
        Если вы сразу обнаружили закладку в C-коде или в ассемблерной реализации алгоритма - не пугайтесь, это исходные файлы. 
        По-честному надо дизассемблировать madryga.pyd.
        Пользуясь http://www2.onlinedisassembler.com/ не нашел.

Описание файлов:
    madryga.py - содержит точку входа в программу, отвечает за разбор аргументов
    cio.pxd - заголовочный файл для cio.pyx
    cio.pyx - cython обертка C-ных функций работы с файлами (дает выигрыш относительно стандартных для python методов чтения/записи в файл) 
    file_encriptor.pyx - cython скрипт осуществляет блочное чтение с использованием cio.pyx, шифрование/расшифрованние блока данных,
      и запись блока на прежнее место в файл  
    madryga.pyx - cython обертка над функциями, описанными в madryga_cipher.h
    madryga_cipher.c - реализация функций описанных в madryga_cipher.h на C
    madryga_cipher.S - реализация функций описанных в madryga_cipher.h на ассемблере
    madryga_cipher.h - заголовочный файл с декларацией методов шифрования/расшифрования
    setup.py - автоматизированная сборка cython .pyx файлов в .pyd модули
    build.bat - bat скрипт для запуска сборки. Возможны два режима сборки
      1) связывания с С-ной реализацией функций шифрования/дешифрования (ключ -c)
      2) связывания с ассемблерной реализацией функций шифрования/дешифрования (без параметров)
    cio.pyd, madryga.pyd, file_encriptor.pyd - скомпилированные модули

Запуск:
    Программа реализована под Python 3.4.1
Параметры запуска:
    madryga.py 
        -k, --key - задает ключ шифрования/расшифрования в 16-ричном виде
        -f, --file - задает файл для зашифрования/расшифрования
        -e - указывает что файл необходимо зашифровать 
        -d - указывает что файл необходимо расшифровать
          если ни один параметр из -e и -d не указан, то выполняется шифрование, если указаны оба то - расшифрование  
        -w - алгоритм шифрует слабо (в режиме закладки), при указании этого параметра ключ шифрования является не обязательным параметром 
        -s, --blockSize - размер блока (должен быть степень 2-ки)
        -i, --iterations - указывает число итераций внешнего цикла

    Пример: python34 madryga.py -f readme.txt -k 237EF99 -s 16 --iterations=10

Сборка:
    Данный пункт является не обязательным - все и так уже собранно в .pyd модули. (Под Windows8.1)
    (при сборке madryga.pyd связывание производилось с madryga_cipher.S - то есть ассемблерной реализацией алгоритма шифрования)
    Для сборки необходим cython (использовал версию 0.21.1) и компилятор gcc (4.8.1).
    В процессе сборки каждый .pyx файл будет "ситонизирован" в .c файл, который затем будет скомпилирован в .pyd модуль
    Для сборки запустить build.bat, убедившись, что все директории и параметры соответствуют вашим директориям установки python, cython и версии python
