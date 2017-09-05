#!/bin/bash

# Add master nodes
gcloud compute instance-groups unmanaged add-instances netsil-cloud-master-ig \
    --instances=$MASTERS \
    --zone $ZONE

# Add agent nodes
gcloud compute instance-groups unmanaged add-instances netsil-cloud-agent-ig \
    --instances=$AGENTS \
    --zone $ZONE
