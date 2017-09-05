#!/bin/bash

# NOTE: This first step is GCP specific and should be refactored away in the future
# Generate additional-hosts
hosts_tmpl=additional-hosts.tmpl
hosts_current=current-hosts.tmp
start_end_ids=

gcloud compute instance-groups list-instances netsil-cloud-agent-ig --zone us-west1-b | tail -n+2 | awk '{print $1}' > ${hosts_current}
python get-new-host.py ${hosts_current}


# Install DCOS agents
ansible-playbook -i additional-hosts add_agents.yml --extra-vars "$start_end_ids agent_type=private"

# Add another agent node, scale apps
ansible-playbook -i additional-hosts netsil/netsil-builder/ansible/cloud-deployment.yml

# GCP specific
# TODO: Add new agent to netsil-cloud-agent-ig 
