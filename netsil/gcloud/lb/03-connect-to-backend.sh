#!/bin/bash
gcloud compute backend-services add-backend ${BASE_KEY}-agent-backend-svc-fe \
    --instance-group ${BASE_KEY}-agent-ig \
    --balancing-mode RATE \
    --max-rate-per-instance 100 \
    --instance-group-zone $ZONE --global

gcloud compute backend-services add-backend ${BASE_KEY}-agent-backend-svc-stats \
    --instance-group ${BASE_KEY}-agent-ig \
    --balancing-mode RATE \
    --max-rate-per-instance 100 \
    --instance-group-zone $ZONE --global

gcloud compute backend-services add-backend ${BASE_KEY}-agent-backend-svc-superuser \
    --instance-group ${BASE_KEY}-agent-ig \
    --balancing-mode RATE \
    --max-rate-per-instance 100 \
    --instance-group-zone $ZONE --global
