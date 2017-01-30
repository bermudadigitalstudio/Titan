#!/usr/bin/env bash
# test Titan inside a disposable Docker container

set -eo pipefail

docker build -t titan .
docker run --rm --name titan_test titan
