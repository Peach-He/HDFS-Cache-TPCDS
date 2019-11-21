#!/bin/bash

#job_id=`grep "mapreduce.Job: Running job: " results/$runid/jobhistory/stdout | awk '{print $7}'`
#echo `date '+%D'` $runid $workload `grep "SortTime" results/$runid/jobhistory/stdout | awk '{print $3}'` `grep "Throughput" results/$runid/jobhistory/stdout | awk '{print $3}'` >> ./results/results.txt
#echo $runid $workload SortTime=`grep "SortTime" results/$runid/jobhistory/stdout | awk '{print $3}'`seconds Throughput=`grep "Throughput =" results/$runid/jobhistory/stdout | awk '{print $3}'`MB/sec

#tpcds        
cp ./workload/$1.sh results/$runid/
mkdir -p results/$runid/UC11
cp /hadoop/hive-testbench/UC11/*.* results/$runid/UC11/

