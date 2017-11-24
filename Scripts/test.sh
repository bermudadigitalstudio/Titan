#!/usr/bin/env bash

set -exo pipefail

docker build -t swift-test ./
docker run --rm swift-test \
  || ( set +x; echo -e "\033[0;31mTests exited with non-zero exit code\033[0m"; tput bel; exit 1 )
