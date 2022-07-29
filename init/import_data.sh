#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE TABLE IF NOT EXISTS signals (
    id SERIAL PRIMARY KEY,
    query_id VARCHAR( 50 ) NOT NULL,
    user_id VARCHAR ( 25 ) NOT NULL,
    type VARCHAR ( 25 ) NOT NULL,
    target VARCHAR ( 255 ) NOT NULL,
    signal_time TIMESTAMP NOT NULL
  );
  COPY signals(query_id, user_id, type, target, signal_time)
    FROM '/signals.csv'
    DELIMITER ','
    CSV HEADER;
EOSQL
