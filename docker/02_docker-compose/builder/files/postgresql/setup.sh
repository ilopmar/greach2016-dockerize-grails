#!/bin/bash
echo "######### CREATING DATABASE ##########"

# Perform all actions as user 'postgres'
export PGUSER=postgres

# Create the reverse-app user and database
psql <<EOSQL
    CREATE DATABASE reverseapp;
    CREATE ROLE reverseapp WITH LOGIN PASSWORD 'reverseapp';
    GRANT ALL PRIVILEGES ON DATABASE reverseapp TO reverseapp;
EOSQL

echo ""
echo "######### DATABASE CREATED ##########"
