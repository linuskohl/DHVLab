#!/bin/bash
#(c) Linus Kohl <kohl@munichresearch.com>

LOGFILE='/var/log/stats/user_stats.log'
TSTAMP=$(date +%s)
NRUSERS=$(users |wc -w)
USERS=$(users | tr ' ' ';')
LOAD=$(sar -u 2 1 |tail -n1 |awk '{print $5}' |tr ',' '.' )
MEMORY=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
mkdir -p `dirname $LOGFILE`
echo $TSTAMP,$LOAD,$MEMORY,$NRUSERS,\"$USERS\" >> $LOGFILE

