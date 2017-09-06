#!/bin/bash
# TODO: require ssl?
# TODO: How do binary logging and HA/failover replica work?
# TODO: How does restoration work?
# TODO: Any cloud sql flags to add?

# Get static IP addresses of agents

# Create the CloudSQL instance
gcloud sql instances create $CLOUDSQL_NAME \
       --database-version=$CLOUDSQL_DB_VERSION \
       --region=$REGION \
       --gce-zone=$ZONE \
       --tier=db-$CLOUDSQL_TIER \
       --storage-auto-increase \
       --storage-type=SSD \
       --storage-size=$CLOUDSQL_STORAGE_SIZE \
       --backup \
       --backup-start-time=10:00 \
       --enable-bin-log \
       --failover-replica-name=$CLOUDSQL_NAME-failover-replica \
       --authorized-networks=35.196.209.188,35.196.105.109 \
       --maintenance-window-day=SAT \
       --maintenance-window-hour=23

