#!/usr/bin/env bash

# Defaults
CREATE_PACKAGE=0
DIRECTORY=".ansible"
VERSION=1
BUILDNO=1

if ( ! getopts ":s:" opt); then
	echo "option -s service-name required";
	exit $E_OPTERROR;
fi

while getopts ":ps:d:v:b:" opt; do
  case $opt in
    p)
      CREATE_PACKAGE=1 >&2
      ;;
    s)
      SERVICE=$OPTARG >&2
      ;;
    d)
      DIRECTORY=$OPTARG >&2
      ;;
    v)
      VERSION=$OPTARG >&2
      ;;
    b)
      BUILDNO=$OPTARG >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Artifact
HASH=$(git rev-parse --short HEAD)
DATE=`date +%Y%m%d`
TAR_NAME="$SERVICE-$VERSION.$DATE.$BUILDNO-$HASH.tar.gz"

# Build
docker run -v $(pwd):/src -w /src laardee/serverless:latest /bin/bash -c "\
npm install && \
if [ -d "$DIRECTORY" ]; then rm $DIRECTORY/* ; fi && \
sls deploy --ansible && \
[[ $CREATE_PACKAGE -eq true ]] || \
{
  tar -zcf $DIRECTORY/$TAR_NAME -C $DIRECTORY $SERVICE.zip $SERVICE.json.j2 ; \
  echo Serverless Ansible Build Plugin: $DIRECTORY/$TAR_NAME created. ;
}"

[[ $? -eq 0 ]] || { echo "Build failed!" ; exit 1; }
