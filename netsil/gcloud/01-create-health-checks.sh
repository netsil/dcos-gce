#!/bin/bash
# Port 80 health check
gcloud compute --project "netsil-dev" http-health-checks \
    create "netsil-cloud-agent-healthcheck-fe" \
    --port "80" \
    --request-path "/login" \
    --check-interval "5" --timeout "5" --unhealthy-threshold "2" --healthy-threshold "2"

# Port 2000 health check
gcloud compute --project "netsil-dev" http-health-checks \
    create "netsil-cloud-agent-healthcheck-stats" \
    --port "2000" \
    --request-path "/status" \
    --check-interval "5" --timeout "5" --unhealthy-threshold "2" --healthy-threshold "2"
