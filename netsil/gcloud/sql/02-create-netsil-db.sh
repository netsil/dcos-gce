#!/bin/bash
set -x
# TODO: Need a way to parameterize the name
host=$(gcloud sql instances list --format=json | jq --raw-output '.[] | select(.name=="netsil-cloud-userdb-rev1") | .ipAddresses | .[].ipAddress')
passwd=`cat userdb-passwd-file`
mysql -h $host -u root -p$passwd -e 'CREATE DATABASE IF NOT EXISTS netsil'
