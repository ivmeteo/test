#!/bin/bash

###########################################################################################
#
# скрипт для зачистки устаревших файлов и паплк в системе
#
# читает маски файлов из конфигурационного файла указанного в параметрах
#
###########################################################################################

LOG_FILE="/var/log/clean.log"

log "begin work" $LOG_FILE

if [ ! $1 ]
then
  echo "$0 <config file name>"
  exit
fi 

for c in `cat $1 | awk -F "#" '{print $1}' | awk -F " " '{print $1 "#" $2 "#" $3 "#" $4}'`
do
  if [ "${c:1:1}" != "#" ]
  then
    DIR=`echo $c | awk -F "#" ' {print $1}'`
    TIME=`echo $c | awk -F "#" ' {print $2}'`
    RM_EMPTY_DIR=`echo $c | awk -F "#" ' {print $3}'`
    CHECK=`echo $c | awk -F "#" ' {print $4}'`
    log "  $DIR ($TIME $RM_EMPTY_DIR $CHECK)" $LOG_FILE
    if [ "$CHECK" == "MODIFY" ]
    then
      # Modify
      CHECK="-mmin"
    else
      # Access
      CHECK="-amin"
    fi
    
    let TIME=$TIME*60
    
    find $DIR $CHECK +$TIME -type f | while read f
    do 
      STAT=`stat -c "modify: %y, access: %x" "$f"`
      LOG_STR="rm file $f ($STAT)"
      log "    $LOG_STR" $LOG_FILE
      rm "$f"
      #echo "$f --- $LOG_STR"
    done
    
    if [ "$RM_EMPTY_DIR" == "Y" ]
    then
      log "    rmdir reqest" $LOG_FILE
      find $DIR -type d -empty | while read d
      do
        LOG_STR="rm dir "$d" (empty)"
        log "    $LOG_STR" $LOG_FILE
        rmdir "$d"
      done
    fi
  fi
done

log "stop work" $LOG_FILE
