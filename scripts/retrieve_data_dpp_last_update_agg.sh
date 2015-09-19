at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

for file in `ls $DPPS_FOLDER`
do
 id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`

 response=$(curl --digest -XGET \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at"  \
     --write-out %{http_code} -s\
     -o $TMPDIR/$file.agg.data \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id/streams/$SAMPLE_DPP_AGG_STREAM/lastUpdate)

     if [ $response != 200 ];
     then
               if [ $response != 500 ];
               then
                  echo "KO... Error retrieving data from DPP agg based on $file -> response: "$response
               else
						echo "No data for ID: "$id", file: "$file", stream: "$SAMPLE_DPP_AGG_STREAM
               fi
     else
                echo "OK... Retrieved data from DPP based on $file, ID: "$id
                echo
     fi

done
