#!/bin/bash

# Общее число папок, включая вложенные
# find <folder> -type d находим все папки, 2> перенапрвялем  весь stderr в никуда | wc -l считаем количесво
echo "Total number of folders (including all nested ones) = $(find $1* 2>/dev/null -type d| wc -l)"
# Топ 5 папок с самым большим весом в порядке убывания (путь и размер)
echo "Top 5 folders with largest size in descending order (path and size)):"
# -exec du -ch {} (ch - позволяет выводить объем в К)
# (-exec значит что find выполнит du для каждой найденной папки)
# исключаем -v лишний элемент "total"
# сортируем в человекочитаемом виде в в обратном порядке
# выводим первых пять элементов
# печатаем в нужном нам порядке, нумеруя
echo "$(find $1* -type d -exec du -ch {} + 2>/dev/null | grep -v total | sort -hr | head -5 | awk '{print NR, "-", $2"/, "$1}')"
# Общее число файлов
# grep ^- оставляем только те строки где - в начале
echo "Total number of files = $(ls -laR $1* 2>/dev/null | grep ^- | wc -l)"
# Число конфигурационных файлов:
echo "Number of:"
# (с расширением .conf)
echo "Configuration files (with the .conf extension) = $(find $1* 2>/dev/null -type f -iname "*.conf" | wc -l)"
# текстовых файлов
echo "Text files = $(find $1* 2>/dev/null -type f -iname "*.txt" | wc -l)"
# исполняемых файлов
echo "Executable files = $(find $1* 2>/dev/null -type f -executable | wc -l)"
# логов (файлов с расширением .log)
echo "Log files (with the extension .log) = $(find $1* 2>/dev/null -type f -iname "*.log" | wc -l)"
# архивов
echo "Archive files = $(find $1* 2>/dev/null -type f -name "*.zip" -o -name "*.7z" -o -name "*.rar" -o -name "*.tar" | wc -l)"
# символических ссылок
echo "Symbolic links = $(find $1* 2>/dev/null -type l | wc -l)"
# Топ 10 файлов с самым большим весом в порядке убывания (путь, размер и тип)
echo "Top 10 files with largest size in descending order (path, size and type):"
for (( i=1; i<=10; i++))
do
    file=$(find $1* 2>/dev/null -type f -exec du -h {} + | sort -rh | head -10 | sed "${i}q;d")
    if ! [[ -z $file ]]; then
        echo -n "$i - "
        echo -n "$(echo $file | awk '{print $2",", $1}'), "
        echo "$(echo $file | grep -m 1 -o -E "\.[^/.]+$" | awk -F . '{print $2}')"
    fi
done
# Топ 10 исполняемых файлов с самым большим весом в порядке убывания (путь, размер и хеш)
echo "Top 10 executable files with largest size in descending order (path, size and hash):"
for (( i=1; i<=10; i++))
do
    file=$(find $1* 2>/dev/null -type f -executable -exec du -h {} + | sort -rh | head -10 | sed "${i}q;d")
    if ! [[ -z $file ]]; then
        echo -n "$i - "
        echo -n "$(echo $file | awk '{print $2",", $1}'), "
        path=$(echo $file | awk '{print $2}')
        hash=$(md5sum $path | awk '{print $1}')
        echo "$hash"
    fi
done