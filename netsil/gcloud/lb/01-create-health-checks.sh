#!/bin/bash
# Port 80 health check
gcloud compute --project "netsil-dev" http-health-checks \
    create "${BASE_KEY}-agent-healthcheck-fe" \
    --port "80" \
    --request-path "/login" \
    --check-interval "5" --timeout "5" --unhealthy-threshold "2" --healthy-threshold "2"

# Port 2001 health check
gcloud compute --project "netsil-dev" http-health-checks \
    create "${BASE_KEY}-agent-healthcheck-stats" \
    --port "2001" \
    --request-path "/status" \
    --check-interval "5" --timeout "5" --unhealthy-threshold "2" --healthy-threshold "2"

# Port 8443 (superuser) health check
gcloud compute --project "netsil-dev" http-health-checks \
    create "${BASE_KEY}-agent-healthcheck-superuser" \
    --port "8443" \
    --request-path "/app/login" \
    --check-interval "5" --timeout "5" --unhealthy-threshold "2" --healthy-threshold "2"
