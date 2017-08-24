#!/bin/bash
gcloud compute url-maps create netsil-cloud-agent-lb --default-service netsil-cloud-agent-backend-svc-fe

# All on 443

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

# Go to :443/*
# /* 
