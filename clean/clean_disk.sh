#!/bin/sh

CONF_FILE=$1
MAX_DBG_SIZE=100000
DBG_DIR="$HOME/log"
DBG_FILE="$DBG_DIR/clean_disk.log"

mkdir $HOME/log

if [ $# != 1 ]
then
	echo "Usage: $0 conf_file_name"
	exit 1
fi
if [ ! -r "$CONF_FILE" ]
then
	echo "Cannot read configuration faile"
	exit 1
fi

find $DBG_DIR  -maxdepth 1 -name `basename $DBG_FILE`  -size +100 -exec mv {} $DBG_FILE.old \; 

echo "-----------------------------------------------------------"
echo " $0 STARTED `date` " >> $DBG_FILE

/usr/bin/awk ' {
	line++
	if ( (substr($1,1,1) != "#") && ($0 != "") )
	{
		if( NF == 2 || NF == 3 )
		{
		dir=""
		n=split( $1, aa , "/" )
		for(i=0;i < n; i++) 
			if( aa[i] != "" )
				dir=sprintf ("%s/%s",dir, aa[i])
		name=aa[n]
		$2=$2*60
		system ( "find -L " dir " -maxdepth 1 -mmin +"$2 " \\( -type f -o -type l \\) " \
					" -name \""name "\"  -print -exec rm -f  {} \\;  >> " debug " ")
				if ( ! $3 )
				{
		system ( "find -L " dir "  -maxdepth 1 -type d -empty " \
				" -name \""name "\"   -print  -exec rmdir {} \\; >> " debug " ")
	 			}
		}else {
			printf ("Error in configuration file - line %d\n",line ) >> debug
		}
	}
} ' debug=$DBG_FILE $CONF_FILE

