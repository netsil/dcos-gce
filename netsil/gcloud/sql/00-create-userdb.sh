#!/bin/bash
# TODO: require ssl?
# TODO: How do binary logging and HA/failover replica work?
# TODO: How does restoration work?
# TODO: Any cloud sql flags to add?

# Get static IP addresses of agents

# Create the CloudSQL instance
gcloud sql instances create netsil-cloud-userdb \
       --database-version=MYSQL_5_7 \
       --region=us-east1 \
       --gce-zone=us-east1-b \
       --tier=db-n1-standard-8 \
       --storage-auto-increase \
       --storage-type=SSD \
       --storage-size=500 \
       --backup \
       --backup-start-time=10:00 \
       --enable-bin-log \
       --failover-replica-name=netsil-cloud-userdb-failover-replica \
       --authorized-networks=35.196.209.188,35.196.105.109 \
       --maintenance-window-day=SAT \
       --maintenance-window-hour=23

