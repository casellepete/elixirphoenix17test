#!/bin/bash
# ensure_postgrescontainer.sh

set -e

if (docker ps | grep postgrescontainer); then
  echo "*** Looks like postgrescontainer is running already! ***"
  echo "*** We'll just let it go so we don't lose the data.  ***"
else
  echo "*** Now starting a new postgrescontainer ***"
  docker rm -f postgrescontainer || true
  docker run --name postgrescontainer -e POSTGRES_PASSWORD=postgres -d postgres
fi

exit 0
