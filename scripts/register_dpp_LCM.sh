at=`cat $ROOT_IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

IDLIST=""

for file in `ls $SOS_FOLDER`
do
	id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
	IDLIST=$IDLIST\"$id\",

done
IDLIST=`echo $IDLIST | perl -pe "s/,$//g"`

for file in `ls $DPPS_FOLDER`
do

  cat $1/$DPPS_FOLDER/$file | perl -pe "s/PLACEHOLDER/$IDLIST/g" > $TMPDIR/$file

  response=$(curl --digest -XPOST \
     --write-out %{http_code} \
     -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: Bearer $at" \
     -d @$TMPDIR/$file \
     -o $1/$IDS_FOLDER/$file.id -s \
     http://$API_PUB_NODES_LCM:$API_PUB_SEC_PORT_LCM/serviceobjects)

     if [ $response != 201 ];
     then
                echo "KO... Error creating DPP based on $file -> response: "$response
     else
		id=`cat $1/$IDS_FOLDER/$file.id | perl -pe "s/\"/\n/g" | head -4 | tail -1`
                echo "OK... Created DPP based on $file, ID: "$id
					 echo "      DPP definition can be found at: "$TMPDIR/$file
     fi
done
