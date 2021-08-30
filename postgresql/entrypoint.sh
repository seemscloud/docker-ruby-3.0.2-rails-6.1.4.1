#!/bin/bash

if [ ! -f .initialized ] ; then
  echo "Initializing, creating database and role.."

  initdb -D data

  pg_ctl start --pgdata data --log log/server.log

  psql -c "CREATE ROLE \"${PG_USERNAME}\";"
  psql -c "CREATE DATABASE \"${PG_DATABASE}\";"
  psql -c "ALTER DATABASE \"${PG_DATABASE}\" OWNER TO \"${PG_USERNAME}\";"
  psql -c "GRANT ALL PRIVILEGES ON DATABASE \"${PG_DATABASE}\" TO \"${PG_USERNAME}\";"
  psql -c "ALTER ROLE \"${PG_USERNAME}\" LOGIN;"
  psql -c "ALTER ROLE \"${PG_USERNAME}\" PASSWORD '${PG_USERNAME}';"
  psql -d "${PG_DATABASE}" -c "ALTER SCHEMA \"public\" OWNER TO \"${PG_USERNAME}\";"
  psql -d "${PG_DATABASE}" -c "GRANT ALL PRIVILEGES ON SCHEMA \"public\" TO \"${PG_USERNAME}\";"

  pg_ctl stop --pgdata data --log log/server.log

  touch .initialized
else
  echo "Already initialized, database and role exists.."
fi

sed "s/#listen_addresses = 'localhost'/listen_addresses = '0.0.0.0'/g" -i data/postgresql.conf
sed "s/#port = 5432/port = ${LISTEN_PORT}/g" -i data/postgresql.conf

postgres -D "${APPDIR}"/data  -c hba_file="${APPDIR}"/pg_hba.conf -c config_file="${APPDIR}"/postgresql.conf