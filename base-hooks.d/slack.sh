#!/bin/sh

# shellcheck disable=SC1091
source /certspotter/utils.sh

if [ -n "${1}" ] && [ -n "${CS_SLACK_URL}" ]; then
  curl -X POST --silent --data-urlencode "payload={\"text\": \"$1\"}" "$CS_SLACK_URL";
fi

