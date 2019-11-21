if [ -z $1 ]
then
	echo "Enter loop"
	exit 1
fi

for loop in `seq 1 $1`:
do
	./pat run
	sleep 60
	stop-dfs.sh
	start-dfs.sh
	sleep 10 
	hdfs dfsadmin -safemode leave
done
