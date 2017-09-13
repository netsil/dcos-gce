#!/bin/bash
set -x
# TODO: Need a way to parameterize the name
host=$(gcloud sql instances list --format=json | jq --raw-output ".[] | select(.name==\"${CLOUDSQL_NAME}\") | .ipAddresses | .[].ipAddress")
passwd=`cat $USERDB_PASSWORD_FILE`
mysql -h $host -u root -p$passwd -e 'CREATE DATABASE IF NOT EXISTS netsil'

# Druid db setup
mysql -h $host -u root -p$passwd -e 'CREATE DATABASE IF NOT EXISTS druid DEFAULT CHARACTER SET utf8'

# create a druid user, and grant it all permission on the database we just created

mysql -h $host -u root -p$passwd -e "GRANT ALL ON druid.* TO 'druid'@'%' IDENTIFIED BY 'diurd'"

# for netsil-dd-agent to monitor druid metrics
mysql -h $host -u root -p$passwd -e "GRANT PROCESS ON *.* TO 'druid'@'%' IDENTIFIED BY 'diurd'"

