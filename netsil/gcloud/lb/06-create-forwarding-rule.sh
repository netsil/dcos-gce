#!/bin/bash
set -x
# Create IP address
gcloud compute addresses create netsil-cloud-address --global

# Get address, put it in netsil_cloud_address 
netsil_cloud_address=$(gcloud compute addresses describe netsil-cloud-address --global --format=json | jq --raw-output '.address')

# Create forwarding rule
gcloud compute forwarding-rules create netsil-cloud-https-forwarding-rule --global --address $netsil_cloud_address \
	--ip-protocol TCP --port-range 443 \
	--target-https-proxy netsil-cloud-https-proxy

gcloud compute forwarding-rules create netsil-cloud-superuser-forwarding-rule --global --address $netsil_cloud_address \
	--ip-protocol TCP --port-range 8080 \
	--target-http-proxy netsil-cloud-superuser-proxy
