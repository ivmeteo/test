#!/bin/bash

#
# скрипт очистки указанной папки (не рекурсивно)
# до указанного размера начиная с самых старых файлов
#
# (с) ivan.krisanov@mail.ru
#

if [ $1 ] && [ $2 ]
then
    DIR="$1"
    MAX_SIZE=$(($2*1024)) # if [ $DF -gt 95 ]
    echo "check dir $DIR for max size $MAX_SIZE KB"

    cd $DIR

    ls -1tr | while read f
    do
	if [ -f "$f" ]
        then
	    DU=`du -s | awk '{print $1}'`
	    echo "  dir size is $DU KB"
	    if [ $DU -gt $MAX_SIZE ]
	    then
        	echo "  delete file '$f'"
        	rm "$f"
    	    else
    		break
    	    fi
        fi
    done
else
    echo "$0 <dir path> <max size in MB>"
fi


