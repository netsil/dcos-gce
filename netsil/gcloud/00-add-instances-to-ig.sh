#!/bin/bash

# Add master nodes
gcloud compute instance-groups unmanaged add-instances netsil-cloud-master-ig \
    --instances=netsil-cloud-master0,netsil-cloud-master1,netsil-cloud-master2 \
    --zone us-east1-b

# Add agent nodes
gcloud compute instance-groups unmanaged add-instances netsil-cloud-agent-ig \
    --instances=netsil-cloud-agent0001,netsil-cloud-agent0002 \
    --zone us-east1-b
