at=`cat $1/$IDS_FOLDER/$ACCESS_TOKEN_FILENAME`


for file in `ls $DPPS_FOLDER`
do
   id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
	echo Retrieving ID: $id
   response=$(curl --digest -XGET -s \
     --write-out %{http_code} \
	  -o $TMPDIR/retrieved_descriptor.json \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: $at" \
     http://$API_PUB_NODES:$API_PUB_SEC_PORT/$id)

     if [ $response != 200 ];
     then
                echo "KO... Error retrieving DPP wih ID: "$id" -> response: "$response
	  else
	  				 cat $TMPDIR/retrieved_descriptor.json
					 echo
     fi
done
