#!/bin/bash
# docker_shell.sh

docker rm -f tk_shell || true

./scripts/ensure_postgrescontainer.sh

set -e

if (docker ps -a | grep tk_shell); then
  docker rm -f tk_shell
fi

docker run -it --name tk_shell \
  -v "$PWD":/tk \
  -v /etc/ssl/cas-certs:/etc/ssl/cas-certs \
  --link postgrescontainer:postgres \
  -p 80:80 \
  -p 443:443 \
  -p 4000:4000 \
  -w /phoenix \
  caselle2/phoenix:v3 \
  bash


exit 0
