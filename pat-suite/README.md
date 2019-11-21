# Collection system provision
To install the tool, make a copy of the "./config_template" file as "./config", 
and make all your edits within the "./config" file.

Be sure to edit the following parameters: 
- ALL_NODES          (this needs to be in a format of <hostname>:<port>; the port
                    is expected to be the port ID of the SSH port, which is often 22)
- WORKER_SCRIPT_DIR  (where worker scripts will live on each worker node)
- WORKER_TMP_DIR     (where workers will store temporary files on each node)


# Test suite provision
Edit or put your scripts under pat-suite/workload foler at first.

current support workloads:

- TeraGen/TeraSort both MR and Spark application
- TestDFSIO write and read
- Some TPC-DS queires
- TPCx-BB

# Start
./auto [script name] [# of loop]

# Result
Results will be store into pat-suite/results/[runid], also can get a quick result by "cat pat-suite/results/results.txt"

You can copy instruments under each [runid] folder into your windows system, then issue "ctrl+q" to execute the excel macro after open "result_templatev1.xlsm" to generate graph result of system metrics.




