#!/bin/bash

set +o xtrace
set -o errexit

if [ docker inspect -f '{{.State.Running}}' dockerlbryweb_app_1 == "true" ]; then
    docker-compose stop app
fi

docker pull sayplastic/lbryweb-prototype
docker-compose run app pipenv run lbryweb/manage.py migrate
docker-compose run app pipenv run lbryweb/manage.py collectstatic --no-input
docker-compose up app
