echo "Id,Type,Size(GB),Total query time,IO intensive query time,Mark,Query19,Query40,Query42,Query52,Query55,Query63,Query68" > summary
for dir in $(ls)
do
if [[ -f "$(pwd)/$dir/UC11/tpc_stats_0.log" && $(cat $(pwd)/$dir/UC11/tpc_stats_0.log|wc -l) -eq 55 ]]
then
totaltime=`awk -F ',' '{NR!=1 && total+=$11} END {print total}' $(pwd)/$dir/UC11/tpc_stats_0.log`
iotime=`awk -F ',' '$6~/19|40|42|52|55|63|68/ {NR!=1 && total+=$11} END {print total}' $(pwd)/$dir/UC11/tpc_stats_0.log`
type=`grep ^perl* $(pwd)/$dir/tpcds-run*.sh | awk 'END {print $6}'`
size=`grep ^perl* $(pwd)/$dir/tpcds-run*.sh | awk 'END {print $7}'`
q19=`awk -F ',' '$6~/19/ {print $11}' $(pwd)/$dir/UC11/tpc_stats_0.log`
q40=`awk -F ',' '$6~/40/ {print $11}' $(pwd)/$dir/UC11/tpc_stats_0.log`
q42=`awk -F ',' '$6~/42/ {print $11}' $(pwd)/$dir/UC11/tpc_stats_0.log`
q52=`awk -F ',' '$6~/52/ {print $11}' $(pwd)/$dir/UC11/tpc_stats_0.log`
q55=`awk -F ',' '$6~/55/ {print $11}' $(pwd)/$dir/UC11/tpc_stats_0.log`
q63=`awk -F ',' '$6~/63/ {print $11}' $(pwd)/$dir/UC11/tpc_stats_0.log`
q68=`awk -F ',' '$6~/68/ {print $11}' $(pwd)/$dir/UC11/tpc_stats_0.log`
echo $dir,$type,$size,$totaltime,$iotime,,$q19,$q40,$q42,$q52,$q55,$q63,$q68 >> summary
fi
done

