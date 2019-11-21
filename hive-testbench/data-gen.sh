#!/bin/bash

./tpcds-setup.sh 2000 text tpcds
sleep 60
./tpcds-setup.sh 2000 orc /user/root/tpcds
sleep 60
./tpcds-setup.sh 2000 parquet /user/root/tpcds
