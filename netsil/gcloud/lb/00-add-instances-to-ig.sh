#!/bin/bash
new_worker=$1

if [[ -n "${new_worker}" ]] ; then
    echo "Adding new worker"
	gcloud compute instance-groups unmanaged add-instances ${BASE_KEY}-agent-ig \
		--instances=${new_worker} \
		--zone $ZONE
else
	# Add master nodes
	gcloud compute instance-groups unmanaged add-instances ${BASE_KEY}-master-ig \
		--instances=$MASTERS \
		--zone $ZONE

	# Add agent nodes
	gcloud compute instance-groups unmanaged add-instances ${BASE_KEY}-agent-ig \
		--instances=$AGENTS \
		--zone $ZONE
fi

