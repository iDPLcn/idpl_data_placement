#!/bin/sh

USERNAME="idpl"
PASSWORD="idpl"
HOSTNAME="localhost:8000"
API_URI="/condor/transfertime/"

SENDER=$1
RECEIVER=$2
TIME_START=$3
TIME_END=$4
EXPECTED_CHECKSUM=$5
CHECKSUM=$6

shift 6
export  "$@"

CHECKSUM_EQUAL=1
API_URL=http://$HOSTNAME$API_URI
DURATION=$[$TIME_END-$TIME_START]

if [ $CHECKSUM != $EXPECTED_CHECKSUM ]
then
    CHECKSUM_EQUAL=0
fi
curl -u $USERNAME:$PASSWORD -H "Content-Type: application/json" -d "{\"source\": \"$SENDER\", \"destination\": \"$RECEIVER\", \"time_start\": $TIME_START, \"time_end\": $TIME_END, \"md5_equal\": $CHECKSUM_EQUAL, \"duration\": $DURATION}" $API_URL
