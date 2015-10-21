at=`cat $ROOT_IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

for file in `ls $DPPS_FOLDER`
do
 id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`

 response=$(curl --digest -XPOST \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at"  \
     --write-out %{http_code} -s\
	  -d @$ROOT_QUERY_FOLDER/$QUERY_FILE \
     -o $TMPDIR/$file.retrieved.data \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id/streams/$SAMPLE_DPP_FILT_STREAM/search)


     if [ $response != 200 ];
     then
                echo "KO... Error querying data from DPP based on $file -> response: "$response
     else
                echo "OK... Retrieved data from DPP based on $file, ID: "$id
					 cat $TMPDIR/$file.retrieved.data
					 echo
     fi
done
