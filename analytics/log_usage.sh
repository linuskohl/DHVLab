#!/bin/bash
#(c) Linus Kohl <kohl@munichresearch.com>

TSTAMP=$(date +%s)
NRUSERS=$(users |wc -w)
USERS=$(users | tr ' ' ';')
LOAD=$(sar -u 2 1 |tail -n1 |awk '{print $5}' |tr ',' '.' )
MEMORY=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo $TSTAMP,$LOAD,$MEMORY,$NRUSERS,\"$USERS\" >> /var/log/statistics.log

