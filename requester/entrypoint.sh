#!/bin/bash

while true; do
  timeout 5 bash -c "</dev/tcp/${REQ_HOST}/${REQ_PORT}" && break
  sleep 1
done

while true; do
  curl "${REQ_HOST}:${REQ_PORT}" -o /dev/null --silent
  sleep 1
done
