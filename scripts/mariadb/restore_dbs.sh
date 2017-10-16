#!/bin/bash
#Quick fix to import Database Backups
#2017_10_10 Linus Kohl
for db_export in *.mysql; do
    db_name=`echo $db_export | sed -e 's/\(.mysql\)*$//g'`
    echo $db_name
    mysql -uroot -e "create database \`$db_name\`"
    mysql -uroot $db_name < $db_export
done
