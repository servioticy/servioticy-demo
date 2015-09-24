#!/bin/bash
. ../env.sh

START_FOLDER=$PWD

mkdir -p $IDS_FOLDER

echo
echo "*********************************"
echo servIoTicy final demo tester
echo  Retrieving stream subscriptions "(private)"
echo "*********************************"
echo

$SCRIPTS/get_access_token.sh $START_FOLDER
$SCRIPTS/retrieve_stream_subscriptions_private.sh $START_FOLDER
