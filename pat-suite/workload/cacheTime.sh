#!/bin/bash

/hadoop/pat-suite/workload/cache.sh /hive/tpcds_bin_partitioned_orc_2000.db orc_2000
echo "orc_2000" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
sleep 60
echo "1 mins later" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
/hadoop/pat-suite/workload/dropCache.sh
sleep 600

/hadoop/pat-suite/workload/cache.sh /hive/tpcds_bin_partitioned_parquet_2000.db parquet_2000
echo "parquet_2000" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
sleep 60
echo "1 mins later" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
/hadoop/pat-suite/workload/dropCache.sh
sleep 600

/hadoop/pat-suite/workload/cache.sh /user/root/tpcds/2000 text_2000
echo "text_2000" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
sleep 60
echo "1 mins later" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
/hadoop/pat-suite/workload/dropCache.sh
sleep 600


/hadoop/pat-suite/workload/cache.sh /hive/tpcds_bin_partitioned_orc_1000.db orc_1000
echo "orc_1000" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
sleep 60
echo "1 mins later" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
/hadoop/pat-suite/workload/dropCache.sh
sleep 600

/hadoop/pat-suite/workload/cache.sh /hive/tpcds_bin_partitioned_parquet_1000.db parquet_1000
echo "parquet_1000" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
sleep 60
echo "1 mins later" >> cacheinfo
hdfs cacheadmin -listPools -stats >> cacheinfo
hdfs dfsadmin -report | sed -n -e '53p' -e '33p' >> cacheinfo
/hadoop/pat-suite/workload/dropCache.sh
sleep 600
