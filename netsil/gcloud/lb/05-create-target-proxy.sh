#!/bin/bash
gcloud compute ssl-certificates create ${BASE_KEY}-cert --certificate ${BASE_KEY}-cert.crt --private-key ${BASE_KEY}-cert.rsa-key
gcloud compute target-https-proxies create ${BASE_KEY}-https-proxy --url-map ${BASE_KEY}-agent-lb --ssl-certificate ${BASE_KEY}-cert
