#!/bin/bash
# Create IP address
gcloud compute addresses create ${BASE_KEY}-address --global

# Get address, put it in netsil_cloud_address
netsil_cloud_address=$(gcloud compute addresses describe ${BASE_KEY}-address --global --format=json | jq --raw-output '.address')

# Create forwarding rule
gcloud compute forwarding-rules create ${BASE_KEY}-https-forwarding-rule --global --address $netsil_cloud_address \
	--ip-protocol TCP --port-range 443 \
	--target-https-proxy ${BASE_KEY}-https-proxy

