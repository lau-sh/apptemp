#!/bin/bash

echo "Starting apptemp container..."

echo "Copying nginx configuration to instance..."
cp -f /srv/nginx/apptemp.cfg /etc/nginx/sites-enabled/default

echo "Starting nginx..."
service nginx start

echo "Copying postgresql configuration to instance..."
cp -f /srv/postgres/postgresql.cfg /etc/postgresql/12/main/postgresql.conf

echo "Starting postgresql..."
service postgresql start

echo "All dependent services started.  Initialization completed."
exec "$@"
