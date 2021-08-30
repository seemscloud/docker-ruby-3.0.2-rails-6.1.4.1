#!/bin/bash

PID_PATH="tmp/pids/server.pid"

if [ -f "${APPDIR}/${PID_PATH}" ]; then
  rm -f "${APPDIR}/${PID_PATH}"
fi

bundler exec rails server --port "${LISTEN_PORT}" --binding 0.0.0.0 --environment "${ENVIRONMENT}"