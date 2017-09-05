#!/bin/bash
gcloud compute instance-groups set-named-ports ${BASE_KEY}-agent-ig \
    --named-ports fe-port:80,stats-port:2001,superuser-port:8443 \
    --zone $ZONE

gcloud compute backend-services create ${BASE_KEY}-agent-backend-svc-fe \
    --http-health-checks ${BASE_KEY}-agent-healthcheck-fe --port-name fe-port --protocol HTTP \
    --global

gcloud compute backend-services create ${BASE_KEY}-agent-backend-svc-stats \
    --http-health-checks ${BASE_KEY}-agent-healthcheck-stats --port-name stats-port --protocol HTTP \
    --global

gcloud compute backend-services create ${BASE_KEY}-agent-backend-svc-superuser \
    --http-health-checks ${BASE_KEY}-agent-healthcheck-superuser --port-name superuser-port --protocol HTTP \
    --global
