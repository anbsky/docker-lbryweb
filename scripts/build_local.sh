#!/bin/bash

set +o xtrace
set -o errexit

PROJECT_PATH="$( cd "$(dirname "$0")/../" ; pwd -P )"

if [ -z ${LOCAL_LBRYWEB+x} ]; then
    echo "Please set LOCAL_LBRYWEB to the location of lbryweb on your disk."
    exit 1
fi
