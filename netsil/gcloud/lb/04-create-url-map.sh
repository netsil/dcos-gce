#!/bin/bash
set -x
stats_backend=${BASE_KEY}-agent-backend-svc-stats
superuser_backend=${BASE_KEY}-agent-backend-svc-superuser

gcloud compute url-maps create ${BASE_KEY}-agent-lb --default-service ${BASE_KEY}-agent-backend-svc-fe

# Remove path matchers
gcloud compute url-maps remove-path-matcher ${BASE_KEY}-agent-lb --path-matcher-name=${BASE_KEY}-lb-path-matcher

# For fe and stats
gcloud compute url-maps add-path-matcher ${BASE_KEY}-agent-lb \
    --path-matcher-name ${BASE_KEY}-lb-path-matcher \
    --default-service ${BASE_KEY}-agent-backend-svc-fe \
    --new-hosts *.netsil.com \
    --path-rules="/intake=$stats_backend,/intake/=$stats_backend,/intake/metrics=$stats_backend,/intake/metrics/=$stats_backend,/intake/metadata=$stats_backend,/intake/metadata/=$stats_backend,/instance_metadata=$stats_backend,/api/v1/series=$stats_backend,/api/v1/series/=$stats_backend,/api/v1/check_run=$stats_backend,/api/v1/check_run/=$stats_backend,/status=$stats_backend,/status/=$stats_backend,/sp-load-balancer/connect=$stats_backend,/sp-load-balancer/connect/=$stats_backend,/tuples/*=$stats_backend"

# Requests come in on 443:
# Go to :2001/*
# /intake/?
# /intake/metrics/?
# /intake/metadata/?
# /instance_metadata
# /tuples/*
# /api/v1/series/?
# /api/v1/check_run/?
# /status/?
# /sp-load-balancer/connect/?

# Go to :80/*
# /* 

# For superuser
gcloud compute url-maps add-path-matcher ${BASE_KEY}-agent-lb \
    --path-matcher-name netsil-superuser-path-matcher \
    --default-service ${BASE_KEY}-agent-backend-svc-fe \
    --new-hosts *.superuser.netsil.com \
    --path-rules="/*=$superuser_backend"

# Go to :8443
# /*

