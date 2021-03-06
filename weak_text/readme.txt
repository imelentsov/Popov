﻿Выполнил: Меленцов Иван
Группа: КБ-501
Задача: 10 - Криптопротокол со слабым текстом

Преамбула:
    Компании, которая очень любит безопасность нужно файловое хранилище обладающие следующими свойствами:
        1) Все данные хранятся в зашифрованном виде (для защиты от конкурентов) 
        2) Данные начальства шифруются криптостойко (а как иначе)
        3) Данные служащих не очень, что бы начальство при желании могло читать их (для обнаружения иноверцев).


Описание работы расшифровщика:
    Расшифровщик пытается расшифровать данные сначала одним способом, если не удалось то другим. 
    Успешной расшифровка считается, если все символы первого блока в ascii.

Описание файлов:
    encryptor.py - программа шифрования текста. Возможно шифрование 2-я способами: слабо и сильно
    decryptor.py - программа расшифровывающая текст независимо от того каким способом он был зашифрован (расшифровщик для начальства)
    cio.pxd - заголовочный файл для cio.pyx
    cio.pyx - cython обертка C-ных функций работы с файлами (дает выигрыш относительно стандартных для python методов чтения/записи в файл) 
    file_encriptor.pyx - cython скрипт осуществляет блочное чтение с использованием cio.pyx, шифрование/расшифрованние блока данных,
      и запись блока на прежнее место в файл  
    madryga.pyx - cython обертка над функциями, описанными в madryga_cipher.h
    madryga_cipher.c - реализация функций описанных в madryga_cipher.h на C
    madryga_cipher.h - заголовочный файл с декларацией методов шифрования/расшифрования
    setup.py - автоматизированная сборка cython .pyx файлов в .pyd модули
    build.bat - bat скрипт для запуска сборки.
    cio.pyd, madryga.pyd, file_encriptor.pyd - скомпилированные модули

Запуск:
    Программа реализована под Python 3.4.1
Параметры запуска:
    encryptor.py 
        -k, --key - задает ключ шифрования в 16-ричном виде
        -f, --file - задает файл для зашифрования
        -w - алгоритм шифрует слабо, при указании этого параметра ключ шифрования является не обязательным параметром 
        -s, --blockSize - размер блока (должен быть степень 2-ки)
        -i, --iterations - указывает число итераций внешнего цикла
    decryptor.py
        -k, --key - задает ключ шифрования в 16-ричном виде
        -f, --file - задает файл для зашифрования
        -s, --blockSize - размер блока (должен быть степень 2-ки)
        -i, --iterations - указывает число итераций внешнего цикла

    Пример: python34 encryptor.py -f readme.txt -k 237EF99 -s 16 --iterations=10 -w
            python34 decryptor.py -f readme.txt -k 237EF99 -s 16 --iterations=10
