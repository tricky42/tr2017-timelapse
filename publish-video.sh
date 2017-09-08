#!/bin/bash

PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
DISTRIBUTION_ID=E2YIH0V7R37ABN
BUCKET_NAME=bucksteeg.de-cdn

if [[ -n "$1" ]]
then
    echo "Changing working directory to '$1'"
    cd $1
fi

echo "> aws s3 sync --acl='public-read' --cache-control='max-age=0, no-cache' --sse='AES256' ./video s3://$BUCKET_NAME/tr2017 --exclude '.DS_Store'"
aws s3 sync --acl='public-read' --cache-control='max-age=0, no-cache' --sse='AES256' ./video s3://$BUCKET_NAME/tr2017 --exclude '.DS_Store' 
