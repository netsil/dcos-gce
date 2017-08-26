#!/bin/bash
master_ig=netsil-cloud-master-ig
agent_ig=netsil-cloud-agent-ig

gcloud compute instance-groups unmanaged create $master_ig --zone us-east1-b
gcloud compute instance-groups unmanaged create $agent_ig --zone us-east1-b
