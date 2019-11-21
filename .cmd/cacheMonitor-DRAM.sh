#! /bin/bash

count=0
pre1=0
cur1=0
pre2=0
cur2=0
while(( $count != 1 ))
do
        count=0
        pre1=$cur1
        cur1=$(hdfs dfsadmin -report | sed -n -e '53p' -e '33p' | awk '{print $4}' | cut -c 2- | awk '{sum+=$1}END{print sum}')
        if [[ $pre1 == $cur1 ]]
        then
                count=`expr $count + 1`
        fi
        sleep 10
done
