#! /bin/bash

hdfs cacheadmin -addPool benchmark
echo "cache $1"
START=$(date +%s)
hadoop jar /root/.cmd/RCache-1.0.jar -d $1 -p benchmark -r 2
/root/.cmd/cacheMonitor-DRAM.sh
END=$(date +%s)
DURATION=$((END-START))
echo $DURATION >> /hadoop/pat-suite/workload/cachetime/$2
