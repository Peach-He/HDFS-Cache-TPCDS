import os
import time

os.system('echo hadoop jar /hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-3.1.2-tests.jar TestDFSIO -read -nrFiles 128 -size 8GB -resFile /tmp/TestDFSIO-aepcache-seq.log > cmd.sh')
os.system("bash /hadoop/pat-suite/run.sh 1 TestDFSIO-aepcache-seq")

os.system('echo hadoop jar /hadoop/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-3.1.2-tests.jar TestDFSIO -read -random -nrFiles 128 -size 8GB -resFile /tmp/TestDFSIO-aepcache-random.log > cmd.sh')
os.system("bash /hadoop/pat-suite/run.sh 1 TestDFSIO-aepcache-random")
