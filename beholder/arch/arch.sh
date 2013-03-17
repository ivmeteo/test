#!/bin/bash

###########################################################################################
#
# скрипт для архивации файлов в системе
#
# читает маски файлов для архивирования из конфигурационного файла указанного в параметрах
# первый архив в месяце делает полным, остальные инкрементными
#
###########################################################################################

ARCH_DIR="/arch"
ARCH_FILE_PRF="$ARCH_DIR/eeepc"

if [ ! $1 ]
then
  echo "$0 <config file name>"
  exit
fi 

YM=`date "+%Y%m"`
D=`date "+%d"`
HN=`date "+%H%M"`
MAIN_ARCH_FILE="${ARCH_FILE_PRF}_${YM}.tar.gz"
INC_ARCH_FILE="${ARCH_FILE_PRF}_${YM}${D}${HN}_INC.tar.gz"
LIST_FILE=`mktemp`

# определяю тип архива инкрементный/основной месячный
if test -e $MAIN_ARCH_FILE
then
  INC=1
  ARCH_FILE=$INC_ARCH_FILE
else
  ARCH_FILE=$MAIN_ARCH_FILE
fi

# определяю список файлов для архивирования
#LAST_ARCH=$ARCH_DIR/`$HOME/bin/fnf.sh $ARCH_DIR`
LAST_ARCH=$ARCH_DIR/`fnf $ARCH_DIR`
echo "last arch is $LAST_ARCH"
for f in `cat $1 | awk -F "#" '{print $1}'`
do 
  if [ $f ]
  then
    #echo $f
    if [ $INC ]
    then
      find $f -type f -newer $LAST_ARCH  >> $LIST_FILE
    else
      find $f -type f >> $LIST_FILE
    fi
  fi
done

# архивирую
tar cvzf $ARCH_FILE -T $LIST_FILE
#cat $LIST_FILE | more

# удаляю временные файлы
if test -e $LIST_FILE
then
  rm $LIST_FILE
fi