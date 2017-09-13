#!/bin/bash
set -x

# Get password
passwd=`cat $USERDB_PASSWORD_FILE`

# Create root user
gcloud sql users create root % \
        --instance=$CLOUDSQL_NAME \
        --password=$passwd

# Create druid user
gcloud sql users create druid % \
        --instance=$CLOUDSQL_NAME \
        --password=diurd
