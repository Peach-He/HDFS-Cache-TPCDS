#!/bin/bash

./tpcds-setup-logs.sh 2000 orc /user/root/tpcds
sleep 60
./tpcds-setup-logs.sh 2000 parquet /user/root/tpcds
sleep 60
