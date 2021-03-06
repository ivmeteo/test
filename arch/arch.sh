#!/bin/bash

!!!

###########################################################################################
#
# скрипт для архивации файлов в системе
#
# читает маски файлов для архивирования из конфигурационного файла указанного в параметрах
# первый архив в месяце делает полным, остальные инкрементными
#
###########################################################################################

ARCH_DIR="/srv/arch/root"
ARCH_FILE_PRF="$ARCH_DIR/root"
ARCH_LOG="/var/log/arch.log"

if [ ! $1 ]
then
  echo "$0 <config file name>"
  exit
fi 

log "---------------------------" $ARCH_LOG
log "begin work" $ARCH_LOG

YM=`date "+%Y%m"`
D=`date "+%d"`
HN=`date "+%H%M"`
MAIN_ARCH_FILE="${ARCH_FILE_PRF}_${YM}.tar.gz"
INC_ARCH_FILE="${ARCH_FILE_PRF}_${YM}${D}${HN}_INC.tar.gz"
LIST_FILE=`mktemp`
ARCH_OUTPUT=`mktemp`

# определяю тип архива инкрементный/основной месячный
if test -e $MAIN_ARCH_FILE
then
  INC=1
  ARCH_FILE=$INC_ARCH_FILE
  LAST_ARCH=$ARCH_DIR/`fnf $ARCH_DIR`
  log "Incremental archive, last arch $LAST_ARCH" $ARCH_LOG
else
  ARCH_FILE=$MAIN_ARCH_FILE
  log "Basic month archive" $ARCH_LOG
fi

# определяю список файлов для архивирования
log "calculate file list" $ARCH_LOG
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

# сбрасываю некорректные (из будущего) даты модификаций файлов
NOW=`date +"%s"`
cat $LIST_FILE | while read f
do
  FMOD=`stat -c%Y "$f"`
  if [ $FMOD -gt $NOW ]
  then
    touch -m "$f"
    log "file $f is from future, update it" $ARCH_LOG
  fi
done

# архивирую
log "start archivate" $ARCH_LOG
#tar cvzf $ARCH_FILE -T $LIST_FILE > $ARCH_OUTPUT
tar --create --gzip --file=$ARCH_FILE --files-from=$LIST_FILE # --gzip --tape-length=50000000 --verbose 
ARCH_RESULT=$?
if [ $ARCH_RESULT != 0 ] 
then
  log "archivate ERROR $ARCH_RESULT!" $ARCH_LOG
fi

#cat $LIST_FILE | more

# удаляю временные файлы
if test -e $LIST_FILE
then
  cat $LIST_FILE >> $ARCH_LOG
  rm $LIST_FILE
fi
if test -e $ARCH_OUTPUT
then
  rm $ARCH_OUTPUT
fi

log "stop work" $ARCH_LOG
