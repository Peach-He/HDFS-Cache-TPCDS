#! /bin/bash

scale=1000
##################################orc#################################
:<<!
/hadoop/pat-suite/workload/cache.sh /hive/tpcds_bin_partitioned_orc_${scale}.db orc_${scale}
echo "orc_${scale}" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
sleep 300
echo "5 mins later" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
hdfs cacheadmin -listDirectives -stats >> cached_files
/root/.cmd/dropCache
/hadoop/pat-suite/auto.sh tpcds-run-orc-${scale}
echo "orc-${scale}-dram runid:" >> info
runid=$(cat /hadoop/pat-suite/runid)
echo $runid >> info
hdfs dfsadmin -report >> cacheinfo
/hadoop/pat-suite/workload/dropCache.sh
mv cached_files cacheinfo info /hadoop/pat-suite/results/$runid
sleep 600
!

##################################parquet#################################
:<<!
/hadoop/pat-suite/workload/cache.sh /hive/tpcds_bin_partitioned_parquet_${scale}.db parquet_${scale}
echo "parquet_${scale}" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
sleep 300
echo "5 mins later" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
hdfs cacheadmin -listDirectives -stats >> cached_files
/root/.cmd/dropCache
/hadoop/pat-suite/auto.sh tpcds-run-parquet-${scale}
echo "parquet-${scale}-dram runid:" >> info
runid=$(cat /hadoop/pat-suite/runid)
echo $runid >> info
hdfs dfsadmin -report >> cacheinfo
/hadoop/pat-suite/workload/dropCache.sh
mv cached_files cacheinfo info /hadoop/pat-suite/results/$runid
sleep 600
!

##################################text#################################

/hadoop/pat-suite/workload/cache.sh /user/root/tpcds/${scale} text_${scale}
echo "text_${scale}" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
sleep 300
echo "5 mins later" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
hdfs cacheadmin -listDirectives -stats >> cached_files
/root/.cmd/dropCache
/hadoop/pat-suite/auto.sh tpcds-run-text-${scale}
echo "text-${scale}-dram runid:" >> info
runid=$(cat /hadoop/pat-suite/runid)
echo $runid >> info
hdfs dfsadmin -report >> cacheinfo
/hadoop/pat-suite/workload/dropCache.sh
mv cached_files cacheinfo info /hadoop/pat-suite/results/$runid
sleep 600

