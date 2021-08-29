#!/bin/bash

sed "s/^port 6379$/port ${LISTEN_PORT}/g" -i "${APPDIR}"/etc/redis.conf
sed "s|^dir .\/$|dir /${APPDIR}\/var|g" -i "${APPDIR}"/etc/redis.conf
sed "s/^bind 127.0.0.1 -::1$/bind 0.0.0.0/g" -i "${APPDIR}"/etc/redis.conf
sed "s/^dbfilename dump.rdb$/dbfilename ${DB_FILENAME}/g" -i "${APPDIR}"/etc/redis.conf

redis-server "${APPDIR}"/etc/redis.conf