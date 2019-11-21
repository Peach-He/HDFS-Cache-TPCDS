#! /bin/bash

scale=2000
##################################orc#################################
:<<!
/hadoop/pat-suite/workload/cache.sh /hive/tpcds_bin_partitioned_orc_${scale}.db orc_${scale}
echo "orc_${scale}" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
df -h | grep pmem >> cacheinfo
ssh sr113 df -h | grep pmem >> cacheinfo
sleep 300
echo "5 mins later:" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
df -h | grep pmem >> cacheinfo
ssh sr113 df -h | grep pmem >> cacheinfo
hdfs cacheadmin -listDirectives -stats >> cached_files
/root/.cmd/dropCache
/hadoop/pat-suite/auto.sh tpcds-run-orc-${scale}
sleep 60
echo "orc-${scale}-aep runid:" >> info
runid=$(cat /hadoop/pat-suite/runid)
echo $runid >> info
/hadoop/pat-suite/workload/dropCache.sh
mv cached_files cacheinfo info /hadoop/pat-suite/results/$runid
sleep 600
!
/root/.cmd/dropCache
/hadoop/pat-suite/auto.sh tpcds-run-orc-${scale}
echo "orc-${scale}-hdd runid:" >> info
runid=$(cat /hadoop/pat-suite/runid)
echo $runid >> info
mv info /hadoop/pat-suite/results/$runid
sleep 60


##################################parquet#################################
:<<!
/hadoop/pat-suite/workload/cache.sh /hive/tpcds_bin_partitioned_parquet_${scale}.db parquet_${scale}
echo "parquet_${scale}" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
df -h | grep pmem >> cacheinfo
ssh sr113 df -h | grep pmem >> cacheinfo
sleep 300
echo "5 mins later:" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
df -h | grep pmem >> cacheinfo
ssh sr113 df -h | grep pmem >> cacheinfo
hdfs cacheadmin -listDirectives -stats >> cached_files
/root/.cmd/dropCache
/hadoop/pat-suite/auto.sh tpcds-run-parquet-${scale}
sleep 60
echo "parquet-${scale}-aep runid:" >> info
runid=$(cat /hadoop/pat-suite/runid)
echo $runid >> info
/hadoop/pat-suite/workload/dropCache.sh
mv cached_files cacheinfo info /hadoop/pat-suite/results/$runid
sleep 600 

/root/.cmd/dropCache
/hadoop/pat-suite/auto.sh tpcds-run-parquet-${scale}
echo "parquet-${scale}-hdd runid:" >> info
runid=$(cat /hadoop/pat-suite/runid)
echo $runid >> info
mv info /hadoop/pat-suite/results/$runid
sleep 60
!
##################################text#################################
:<<!
/hadoop/pat-suite/workload/cache.sh /user/root/tpcds/${scale} text_${scale}
echo "text_${scale}" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
df -h | grep pmem >> cacheinfo
ssh sr113 df -h | grep pmem >> cacheinfo
sleep 300
echo "5 mins later:" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
df -h | grep pmem >> cacheinfo
ssh sr113 df -h | grep pmem >> cacheinfo
hdfs cacheadmin -listDirectives -stats >> cached_files
/root/.cmd/dropCache
/hadoop/pat-suite/auto.sh tpcds-run-text-${scale}
sleep 60
echo "text-${scale}-aep runid:" >> info
runid=$(cat /hadoop/pat-suite/runid)
echo $runid >> info
/hadoop/pat-suite/workload/dropCache.sh
mv cached_files cacheinfo info /hadoop/pat-suite/results/$runid
sleep 600 

/root/.cmd/dropCache
/hadoop/pat-suite/auto.sh tpcds-run-text-${scale}
echo "text-${scale}-hdd runid:" >> info
runid=$(cat /hadoop/pat-suite/runid)
echo $runid >> info
cat /hadoop/pat-suite/runid >> info
mv info /hadoop/pat-suite/results/$runid
sleep 60
!
