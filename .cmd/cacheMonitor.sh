#!/bin/bash

count=0
pre1=0
cur1=0
pre2=0
cur2=0
while(( $count != 2 ))
do
        count=0
        pre1=$cur1
        cur1=$(ssh root@sr112 df -h | grep pmem | awk '{print $3}' | sed 's/.$//' | awk '{sum+=$1}END{print sum}')
        if [[ $pre1 == $cur1 ]]
        then
                count=`expr $count + 1`
        fi
        pre2=$cur2
        cur2=$(ssh root@sr113 df -h | grep pmem | awk '{print $3}' | sed 's/.$//' | awk '{sum+=$1}END{print sum}')
        if [[ $pre2 == $cur2 ]]
        then
                count=`expr $count + 1`
        fi
        sleep 20
done
