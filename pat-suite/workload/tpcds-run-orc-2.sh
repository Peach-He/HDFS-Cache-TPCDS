#!/bin/bash

HIVE_TESTBENCH=/hadoop/hive-testbench
QUERY_DIR=$HIVE_TESTBENCH/UC11
mkdir -p ${QUERY_DIR}
run_id=0

if [ $2x != x ]
then 
    run_id=$2
fi 

#clean up result folder
rm -f $QUERY_DIR/spark_parquet_*
rm -f $QUERY_DIR/spark_orc_*
rm -f $QUERY_DIR/spark_text_*

echo "query_set,run_id,engine,format,scale_factor,query,status,start,end,tot_time,query_time,rows" > $QUERY_DIR/tpc_stats_${run_id}.log

#run 1TB queries
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id spark parquet 1000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id hive parquet 1000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id presto parquet 1000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id presto orc 1000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id spark orc 1000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id hive-spark orc 1000

#run 2GB queries
perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id spark orc 2
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id presto parquet 10000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id hive orc 10000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id spark orc 10000

#run 10TB queries
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id spark parquet 10000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id presto parquet 10000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id hive orc 10000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id spark orc 10000

#run 100TB queries
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id presto orc 100000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id spark parquet 100000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id hive orc 100000
#perl $HIVE_TESTBENCH/runSuite.pl $QUERY_DIR $run_id hive-spark orc 100000

cp $QUERY_DIR/tpc_stats_${run_id}.log $QUERY_DIR/tpc_stats_${run_id}.log.`date "+%F-%T"`
