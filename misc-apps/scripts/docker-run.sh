#!/bin/bash

WORK_DIR="$( cd -L "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"

docker run -d --rm --name misc-apps -p9090:9080 -p9543:9443 -e MY_POD_NAME=ONLYME misc-apps

