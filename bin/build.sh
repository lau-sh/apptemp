#!/bin/bash

cp cfg/apptemp.cfg /srv/data/nginx/
cp cfg/*.pem /srv/data/nginx/certs/
cp cfg/cert.pass /srv/data/nginx/certs/
docker compose build
