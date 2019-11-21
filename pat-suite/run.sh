lop=1

function usage() {
	echo -e "Usage:\trun.sh LOOP [SCRIPT_NAME]"
	echo -e "Params:\tLOOP\tScript loop count"
	echo -e "\tSCRIPT_NAME\tWhich script want to execute"
}

if [ "$1" != "" ]
then
	lop=$1
else
	usage
	exit 1
fi

action='tpcds-run'
if [ "$2" != "" ]
then
	action=$2
fi

for((i=0;i<$lop;i++))
do
	d=$(date '+%Y-%m-%d-%H-%M')
	name=${d}-${action}-${i}
	curdir=/root/Emon/emon-data/${d}-${action}-${i}

	bash ~/.cmd/dropCache	

	echo "-_-_-_-_-  lOOP: $i -_-_-_-_-"
	echo "##Start ${name} testing ##"

	./pat run $d-$action-$i

done
