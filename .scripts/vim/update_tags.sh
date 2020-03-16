#!/bin/sh
tags_folder="$HOME/.vim/tags"

printf "Updating clang_tags ... "
ctags -R    -f "$tags_folder"/clang_tags /usr/include/*.h
ctags -R -a -f "$tags_folder"/clang_tags /usr/include/clang
ctags -R -a -f "$tags_folder"/clang_tags /usr/local/gcc-arm-none-eabi-6-2017-q1-update/arm-none-eabi/include
echo "done"

printf "Updating cpp_tags ... "
ctags -R    -f "$tags_folder"/cpp_tags /usr/include/*.h
ctags -R -a -f "$tags_folder"/cpp_tags /usr/include/c++
echo "done"

printf "Updating arduino_tags ... "
ctags -R -f "$tags_folder"/arduino_tags /home/dedukun/.platformio/packages/framework-arduinoavr/cores/arduino/*.h
echo "done"
