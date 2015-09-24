at=`cat $ROOT_IDS_FOLDER/$ACCESS_TOKEN_FILENAME`

curl -H "Content-Type: application/json;charset=UTF-8" \
     -H "Authorization: Bearer $at" \
     -X GET http://$IDM_HOST/idm/user/info/ -s \
     | perl -pe "s/\"/\n/g" | tail -2 | head -1 \
     > $ROOT_IDS_FOLDER/$RANDOM_ACCESS_TOKEN_FILENAME 
