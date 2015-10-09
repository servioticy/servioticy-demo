#!/bin/bash

if [ -z "$ROOT" ]
then
    ROOT=$(while ! test -e env.sh.sample; do cd ..; done; pwd)
    export ROOT
fi

. $ROOT/env.sh

START_FOLDER=$PWD

mkdir -p $IDS_FOLDER


echo
echo "*********************************"
echo    servIoTicy final demo tester
echo Setting lamp state "(lampid,state)"
echo "*********************************"


$SCRIPTS/get_access_token.sh $START_FOLDER
$SCRIPTS/get_random_access_token.sh $START_FOLDER
$SCRIPTS/set_lamp_state.sh $START_FOLDER $1 $2

echo
