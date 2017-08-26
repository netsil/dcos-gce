#!/bin/bash
set -x

# Get password
passwd=`cat userdb-passwd-file`

# Create root user
gcloud sql users create root % \
        --instance=netsil-cloud-userdb \
        --password=$passwd
