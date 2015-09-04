at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

  response=$(curl --digest -XGET -s  \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at" \
	  -o $TMPDIR/solist.txt \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT)


for id in `cat  $TMPDIR/solist.txt | perl -pe "s/\[//g" | perl -pe "s/\]//g" | perl -pe "s/,/\n/g" | perl -pe "s/\"//g"`
do
	echo ID: $id

done

