#!/bin/bash
source basic.sh

workload=$1.sh
clean=$2

yarn_rm_node=`get_hosts|awk '{print $1}'`
checkAppIsRunning(){
    numOfApp=`ssh root@$yarn_rm_node yarn application -list|grep "Total number of"|awk -F":" '{print $4}'`
    if [ $numOfApp -gt 0 ]
    then
        echo "please wait for other applicaitons to complete." 
        exit 0
    fi
}

checkAppIsRunning

clean_hdfs_trash(){
    ssh root@$yarn_rm_node "hadoop fs -rm -r -skipTrash .Trash/Current/* benchmarks"
}
if [ $clean -gt 0 ]
then
	echo "clean hdfs trashes"
	clean_hdfs_trash
fi

runid=`cat runid`
runid=`expr $runid + 1`
echo $runid > runid
echo [$HOSTNAME][$0][`date +"%Y-%m-%d %T"`] RunID=$runid

# for every node in the physical bluedata cluster
all_hosts=$(awk '(/^ALL_NODES/){for (i=2; i<=NF; i++) print $i}' ./config)
for host in $all_hosts;do
    echo [$HOSTNAME][$0][`date +"%Y-%m-%d %T"`] Preparing $host ...
    #ssh $host "echo 1 > /proc/sys/vm/drop_caches"
    #ssh $host ps -ef|grep pat_tmp |awk '{print $2}'|xargs kill -9
    #ssh $host "ntpdate -u 10.239.44.195;echo 1 > /proc/sys/vm/drop_caches " &
    ssh $host "echo 1 > /proc/sys/vm/drop_caches " &
    # If you want to clear the cache, just run below command.
    #ssh $host "echo 1 > /proc/sys/vm/drop_caches" &
done
wait
#sleep 30

# the Resource Manager node of the virtual/physical YARN cluster
# physical cluster

echo [$HOSTNAME][$0][`date +"%Y-%m-%d %T"`] Copying workload files to the SUT...
ssh root@$yarn_rm_node mkdir -p /tmp/pat_workload
scp ./workload/* root@$yarn_rm_node:/tmp/pat_workload

export workload runid yarn_rm_node
