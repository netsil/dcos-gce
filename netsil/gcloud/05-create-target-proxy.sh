#!/bin/bash
gcloud compute ssl-certificates create netsil-cloud-cert --certificate 1f4de9cd5f6616bb.crt --private-key 1f4de9cd5f6616bb.rsa-key
gcloud compute target-https-proxies create netsil-cloud-https-proxy --url-map netsil-cloud-agent-lb --ssl-certificate netsil-cloud-cert
