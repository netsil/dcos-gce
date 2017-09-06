#!/bin/bash

# Add master nodes
gcloud compute instance-groups unmanaged add-instances ${BASE_KEY}-master-ig \
    --instances=$MASTERS \
    --zone $ZONE

# Add agent nodes
gcloud compute instance-groups unmanaged add-instances ${BASE_KEY}-agent-ig \
    --instances=$AGENTS \
    --zone $ZONE
