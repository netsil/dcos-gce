#!/bin/bash
set -x
host=$(gcloud sql instances list --format=json | jq --raw-output '.[] | select(.name=="$CLOUDSQL_NAME") | .ipAddresses | .[].ipAddress')
passwd=`cat userdb-passwd-file`
mysql -h $host -u root -p$passwd -e 'CREATE DATABASE IF NOT EXISTS netsil'
