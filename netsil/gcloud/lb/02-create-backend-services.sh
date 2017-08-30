#!/bin/bash
gcloud compute instance-groups set-named-ports netsil-cloud-agent-ig \
    --named-ports fe-port:80,stats-port:2001,superuser-port:8443 \
    --zone $ZONE 

gcloud compute backend-services create netsil-cloud-agent-backend-svc-fe \
    --http-health-checks netsil-cloud-agent-healthcheck-fe --port-name fe-port --protocol HTTP \
    --global
    
gcloud compute backend-services create netsil-cloud-agent-backend-svc-stats \
    --http-health-checks netsil-cloud-agent-healthcheck-stats --port-name stats-port --protocol HTTP \
    --global

gcloud compute backend-services create netsil-cloud-agent-backend-svc-superuser \
    --http-health-checks netsil-cloud-agent-healthcheck-superuser --port-name superuser-port --protocol HTTP \
    --global
