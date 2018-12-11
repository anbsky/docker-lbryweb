#!/bin/bash

set +o xtrace
set -o errexit

PROJECT_PATH="$( cd "$(dirname "$0")/../" ; pwd -P )"

if [ -d "$PROJECT_PATH/source" ]; then
    (cd "$PROJECT_PATH/source" && git pull)
else
    git clone -b prototype https://github.com/lbryio/lbryweb.git ./source
fi

docker build -t sayplastic/lbryweb-prototype .
docker push sayplastic/lbryweb-prototype
