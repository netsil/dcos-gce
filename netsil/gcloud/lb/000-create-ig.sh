#!/bin/bash
gcloud compute instance-groups unmanaged create $MASTER_IG --zone $ZONE
gcloud compute instance-groups unmanaged create $AGENT_IG --zone $ZONE
