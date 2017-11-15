#!/bin/bash

TWILIO_ACCOUNT_SID=""
TWILIO_AUTH_TOKEN=""
PHONE_NUMBER_FROM=""
PHONE_NUMBER_TO=""
DOB=""

case "$OSTYPE" in
  darwin*)
    DATE_START=$(date -j -f "%Y-%m-%d" "${DOB}" "+%s")
    DATE_END=$(date "+%s")
    ;;
  linux*)
    DATE_START=$(date --date "${DOB}" "+%s")
    DATE_END=$(date "+%s")
    ;;
esac

DAYS_LEFT=$(( ($DATE_END - $DATE_START) / 86400 ))

MSG_BODY=$(printf "Good Day to be Alive!\n%s/30000" "${DAYS_LEFT}")

curl -s -X POST \
    -F "Body=${MSG_BODY}" \
    -F "From=${PHONE_NUMBER_FROM}" \
    -F "To={$PHONE_NUMBER_TO}" \
    "https://api.twilio.com/2010-04-01/Accounts/${TWILIO_ACCOUNT_SID}/Messages.json" \
    -u "${TWILIO_ACCOUNT_SID}:${TWILIO_AUTH_TOKEN}"
