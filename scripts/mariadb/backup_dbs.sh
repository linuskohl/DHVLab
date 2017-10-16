#!/bin/bash
#2017 Linus Kohl <linus@munichresearch.com>
#Replace path of location and file containing credentials 

BACKUPLOCATION=XXXXXXX

#clean up
mkdir -p $BACKUPLOCATION
rm -Rf $BACKUPLOCATION/*.mysql.gz

#get list of databases
mysql --defaults-extra-file=XXXXXX -B -N -e "show databases" | while read db
do
   BACKUPFILE=$BACKUPLOCATION/$db.mysql.gz
   echo "Backing up $db into $BACKUPFILE"
   /usr/bin/mysqldump  --defaults-extra-file=XXXXXX --skip-lock-tables $db |gzip -6 -v > $BACKUPFILE
done


