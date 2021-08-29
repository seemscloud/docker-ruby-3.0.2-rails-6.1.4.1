#!/bin/bash

if [ -f "/opt/app/tmp/pids/server.pid" ]; then
  rm -f /opt/app/tmp/pids/server.pid
fi

bundler exec rails server --port ${LISTEN_PORT} --binding 0.0.0.0 --environment ${ENVIRONMENT}