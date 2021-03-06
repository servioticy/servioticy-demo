at=`cat $ROOT_IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

for file in `ls $SOS_FOLDER`
do
 id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`

 response=$(curl --digest -XGET \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at"  \
     --write-out %{http_code} -s\
	  -o $TMPDIR/lastupdate.data \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id/streams/$SAMPLE_STREAM/lastUpdate)


     if [ $response != 200 ];
     then
     				if [ $response != 500 ];
     				then
						echo "KO... Error retrieving data from SO based on $file -> response: "$response
               else
						echo "No data for ID: "$id
					fi
     else
                echo "OK... Retrieved data from SO based on $file, ID: "$id
					 cat $TMPDIR/lastupdate.data
					 echo
     fi
done
