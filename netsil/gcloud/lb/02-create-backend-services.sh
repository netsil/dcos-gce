#!/bin/bash
gcloud compute instance-groups set-named-ports netsil-cloud-agent-ig \
    --named-ports fe-port:80 \
    --zone $ZONE 

gcloud compute instance-groups set-named-ports netsil-cloud-agent-ig \
    --named-ports stats-port:2001 \
    --zone $ZONE

gcloud compute backend-services create netsil-cloud-agent-backend-svc-fe \
    --http-health-checks netsil-cloud-agent-healthcheck-fe --port-name fe-port --protocol HTTP \
    --global
    
gcloud compute backend-services create netsil-cloud-agent-backend-svc-stats \
    --http-health-checks netsil-cloud-agent-healthcheck-stats --port-name stats-port --protocol HTTP \
    --global
