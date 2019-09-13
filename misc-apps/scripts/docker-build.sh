#!/bin/bash

WORK_DIR="$( cd -L "$( dirname "${BASH_SOURCE[0]}" )"/.. && pwd )"

docker build --rm -t misc-apps $WORK_DIR

