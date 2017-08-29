#!/bin/bash
master_ig=netsil-cloud-master-ig
agent_ig=netsil-cloud-agent-ig

gcloud compute instance-groups unmanaged create $master_ig --zone $ZONE
gcloud compute instance-groups unmanaged create $agent_ig --zone $ZONE
