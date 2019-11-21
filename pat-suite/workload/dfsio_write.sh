#!/bin/bash

# This script is used to run TeraSort workload from the ResourceManager node of a YARN cluster, either physical or virtual.
# This script should have no dependency on anything other than the Haddop environment.

s3_bucket="s3a://bdaas-demo-dfs/"

INPUT_HDFS=/TestDFSIO/Input
OUTPUT_HDFS=/user/root/benchmarks/TestDFSIO/io_data


export HADOOP_HOME=/hadoop
export HADOOP_EXECUTABLE=$HADOOP_HOME/bin/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop/
export MAPREDUCE_HOME=$HADOOP_HOME/share/hadoop/mapreduce
export HADOOP_TEST_JAR=$MAPREDUCE_HOME/hadoop-mapreduce-client-jobclient-3.1.2-tests.jar


PARAMS=""
#PARAMS="$PARAMS -Dmapreduce.map.output.compress=true"
#PARAMS="$PARAMS -Dmapreduce.input.fileinputformat.split.minsize=536870912"
#PARAMS="$PARAMS -Dmapreduce.map.memory.mb=2048"
#PARAMS="$PARAMS -Dmapreduce.map.java.opts=-Xmx1638m"
#PARAMS="$PARAMS -Dmapreduce.task.io.sort.mb=768"
#PARAMS="$PARAMS -Dmapreduce.task.io.sort.factor=100"
#PARAMS="$PARAMS -Dmapreduce.map.sort.spill.percent=0.99"
#PARAMS="$PARAMS -Dmapreduce.reduce.memory.mb=2048"
#PARAMS="$PARAMS -Dmapreduce.reduce.java.opts=-Xmx1638m"
#PARAMS="$PARAMS -Dyarn.app.mapreduce.am.resource.mb=2048"
#PARAMS="$PARAMS -Dyarn.app.mapreduce.am.command-opts=-Xmx1638m"
#PARAMS="$PARAMS -Dmapreduce.job.reduce.slowstart.completedmaps=0.90"
#PARAMS="$PARAMS -Dmapreduce.reduce.shuffle.merge.percent=0.80"
#PARAMS="$PARAMS -Dmapred.map.tasks.speculative.execution=false"
#PARAMS="$PARAMS -Dmapred.reduce.tasks.speculative.execution=false"
PARAMS="$PARAMS -Dtest.build.data=/user/root/benchmarks/TestDFSIO"
#PARAMS="$PARAMS -Dfs.defaultFS=$s3_bucket"

echo [`date +"%Y-%m-%d %T"`] ==================== TestDFSIO ======================
echo [`date +"%Y-%m-%d %T"`] Output directory: $OUTPUT_HDFS
echo [`date +"%Y-%m-%d %T"`] Removing any existing output data...
$HADOOP_EXECUTABLE jar $HADOOP_TEST_JAR TestDFSIO -Dtest.build.data=/user/root/benchmarks/TestDFSIO -clean
echo [`date +"%Y-%m-%d %T"`] Starting ...

START=$(date +%s)
set -x
$HADOOP_EXECUTABLE jar $HADOOP_TEST_JAR TestDFSIO $PARAMS -write -nrFiles 128 -size 8GB -resFile /tmp/DFSIO-write.log
set +x
END=$(date +%s)
DURATION=$((END-START))
SIZE=`$HADOOP_EXECUTABLE fs -du -s $OUTPUT_HDFS |awk '{print $1}'`

echo [`date +"%Y-%m-%d %T"`] Run completed. 
echo DataSize = $SIZE bytes
echo SortTime = $DURATION seconds
echo Throughput = `echo "scale=2; $SIZE / $DURATION / 1024 / 1024"|bc` MB/sec
echo [`date +"%Y-%m-%d %T"`] ==================== TestDFSIO ======================
