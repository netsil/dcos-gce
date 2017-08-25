#!/bin/bash
set -x
stats_backend=netsil-cloud-agent-backend-svc-stats

gcloud compute url-maps create netsil-cloud-agent-lb --default-service netsil-cloud-agent-backend-svc-fe

# Remove path matchers
gcloud compute url-maps remove-path-matcher netsil-cloud-agent-lb --path-matcher-name=netsil-stats-path-matcher

gcloud compute url-maps add-path-matcher netsil-cloud-agent-lb \
    --path-matcher-name netsil-stats-path-matcher \
    --default-service netsil-cloud-agent-backend-svc-fe \
    --new-hosts *.netsil.com \
    --path-rules="/intake=$stats_backend,/intake/=$stats_backend,/intake/metrics=$stats_backend,/intake/metrics/=$stats_backend,/intake/metadata=$stats_backend,/intake/metadata/=$stats_backend,/instance_metadata=$stats_backend,/api/v1/series=$stats_backend,/api/v1/series/=$stats_backend,/api/v1/check_run=$stats_backend,/api/v1/check_run/=$stats_backend,/status=$stats_backend,/status/=$stats_backend,/sp-load-balancer/connect=$stats_backend,/sp-load-balancer/connect/=$stats_backend,/tuples/v([0-9-.]+)=$stats_backend"

# Requests come in on 443:
# Go to :2001/*
# /intake/?
# /intake/metrics?
# /intake/metadata?
# /instance_metadata
# /tuples/v([0-9-\.]+)
# /api/v1/series/?
# /api/v1/check_run/?
# /status/?
# /sp-load-balancer/connect/?

# Go to :80/*
# /* 
