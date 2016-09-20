#!/bin/sh -e
# Only use sudo if there's no configured remote host
if [ -n "${DOCKER_HOST}" ]
then
	PRE=''
else
	PRE='sudo'
fi

if ! [ -f aws.env ]
then
	echo "Please create an \"aws.env\" file with credentials"
	exit 1
fi

if [ "$#" -ne 2 ]
then
	echo "Usage: ${0} PORT STREAM_NAME"
	exit 1
fi

${PRE} docker run --env-file=aws.env --rm --name "koupler-${2}" -p="${1}":4567 -it $KOUPLER -http -streamName "${2}"
