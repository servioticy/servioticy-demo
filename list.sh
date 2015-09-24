#!/bin/bash

if [ -z "$ROOT" ]
then
    ROOT=$(while ! test -e env.sh.sample; do cd ..; done; pwd)
    export ROOT
fi

. $ROOT/env.sh

mkdir -p $IDS_FOLDER
mkdir -p $TMPDIR

echo
echo "*********************************"
echo servIoTicy final demo tester
echo  Listing SOs and DPPs
echo "*********************************"
echo

$SCRIPTS/get_access_token.sh $START_FOLDER
$SCRIPTS/get_random_access_token.sh $START_FOLDER
$SCRIPTS/list_so_ids.sh $START_FOLDER

echo Done.
echo
