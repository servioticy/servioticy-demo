#!/bin/bash
. env.sh

START_FOLDER=$PWD

mkdir -p $IDS_FOLDER

echo
echo "*********************************"
echo servIoTicy final demo tester
echo  Checking basic functions
echo "*********************************"
echo

./deploy.sh
./list.sh
./generate_data.sh
./retrieve_last_updates.sh
./undeploy.sh
./list.sh

echo Done.
echo
