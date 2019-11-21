#!/bin/bash
source basic.sh

printUsage(){
    echo "Usage: ./auto [workload name]"
    exit -1
}


if [ $# -lt 1 ]
then 
    printUsage
elif [ `find ./workload -type f -name $1.sh|wc -l` -ne 1 ] 
then
    echo "Workload can't be found."
    exit -1
fi 

#exit
loop=1
if [ "$2" != "" ]
then
    loop=$2
fi
echo "loop = $loop"

clean=0
if [ "$3" != "" ]
then
    clean=$3
fi
echo "clean = $clean"

head=`get_hosts|awk '{print $1}'`

echo "head;"$head
for((i=0;i<$loop;i++))
do
	source ./workload_prepare.sh $1 $clean
	./pat run ${runid}

	scp root@$head:/tmp/result.tgz ./results/${runid}/
	
	source ./workload_teardown.sh
	echo "*****************loop $i done******************"
#	sleep 30
done
