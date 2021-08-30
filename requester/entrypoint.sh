#!/bin/bash

while true; do
  timeout 5 bash -c "</dev/tcp/${REQ_HOST}/${REQ_PORT}" && break
  sleep 1
done

while true; do
  curl http://"${REQ_HOST}:${REQ_PORT}" -o /dev/null
  sleep 1
done
