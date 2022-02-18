#!/bin/bash
 
if [ -z $1 ]; then
        echo "Usage: $(basename $0) <mfa-code>"
        exit 1
fi
 
TEMP=$(mktemp)
FILE="$HOME/.aws_tmp"
touch $FILE
 
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset AWS_ACCESS_KEY_ID
 
if [ -z $2 ]; then
  aws sts get-session-token --serial-number arn:aws:iam::327667905059:mfa/anderson.menezes --token-code $1 --duration-seconds 14400 --output json >$TEMP
else
  aws sts get-session-token --serial-number arn:aws:iam::327667905059:mfa/anderson.menezes --token-code $1 --duration-seconds 14400 --profile $2 --output json >$TEMP
fi
 
export AWS_ACCESS_KEY_ID=$(cat $TEMP | jq -r '.[].AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(cat $TEMP | jq -r '.[].SecretAccessKey')
export AWS_SESSION_TOKEN=$(cat $TEMP | jq -r '.[].SessionToken')
 
cat <<EOF >$FILE
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
export AWS_SESSION_TOKEN="$AWS_SESSION_TOKEN"
EOF
 
cat $FILE
 
rm -f $TEMP
