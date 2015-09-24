#!/bin/bash
. ../env.sh

START_FOLDER=$PWD

mkdir -p $IDS_FOLDER

echo
echo "*********************************"
echo servIoTicy final demo tester
echo  Undeploying infrastructure
echo "*********************************"
echo

$SCRIPTS/get_access_token.sh $START_FOLDER
$SCRIPTS/get_random_access_token.sh $START_FOLDER
$SCRIPTS/delete_dpp.sh $START_FOLDER
$SCRIPTS/delete_so.sh $START_FOLDER

echo Done.
echo
