#!/bin/bash
# Create IP address
gcloud compute addresses create netsil-cloud-address --global

# TODO: Get address, put it in netsil_cloud_address 

# Create forwarding rule
gcloud compute forwarding-rules create netsil-cloud-https-forwarding-rule --global \ 
	--address $netsil_cloud_address \
	--ip-protocol TCP --port-range 443 \
	--target-https-proxy netsil-cloud-https-proxy

