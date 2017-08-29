#!/bin/bash
gcloud compute backend-services add-backend netsil-cloud-agent-backend-svc-fe \
    --instance-group netsil-cloud-agent-ig \
    --balancing-mode RATE \
    --max-rate-per-instance 100 \
    --instance-group-zone $ZONE --global

gcloud compute backend-services add-backend netsil-cloud-agent-backend-svc-stats \
    --instance-group netsil-cloud-agent-ig \
    --balancing-mode RATE \
    --max-rate-per-instance 100 \
    --instance-group-zone $ZONE --global 

gcloud compute backend-services add-backend netsil-cloud-agent-backend-svc-superuser \
    --instance-group netsil-cloud-agent-ig \
    --balancing-mode RATE \
    --max-rate-per-instance 100 \
    --instance-group-zone $ZONE --global 
