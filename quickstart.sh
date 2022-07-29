#!/bin/bash

#Download the data - we'll be using the signals data from the AI-Powered Search book (https://www.manning.com/books/ai-powered-search)
printf 'Downloading, extracting and moving the data to the data directory'
wget https://github.com/ai-powered-search/retrotech/raw/master/signals.tgz
tar xzvf signals.tgz
mv signals.csv data

#Run Postgres and populate it with the downloaded signal data
printf 'Run PostgreSQL with compose file docker-compose.yml'
docker-compose up -d

#Run Apache Superset container on port 8080 connected to the network in which the Postgres db is running
printf 'Run Run Apache Superset on port 8080'
docker run -d -p 8080:8088 --network="superset" --name superset apache/superset

#Create an admin user
printf 'Creating an admin user...'
docker exec -it superset superset fab create-admin \
              --username admin \
              --firstname Superset \
              --lastname Admin \
              --email admin@superset.com \
              --password admin

#Upgrade internal database
printf 'Upgrading internal database...'
docker exec -it superset superset db upgrade

#Initialize Apache Superset
printf 'Initializing Apache Superset...'
docker exec -it superset superset init

printf 'Done! Open http://localhost:8080 in your browser and loging with username "admin" and password "admin"'
