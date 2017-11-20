#!/bin/bash
export APPS_DIR=${APPS_DIR:-"/home/centos/netsil-dcos-gce/netsil/netsil-builder/apps"}

#NOTE: This first step is GCP specific and should be refactored away in the future
current_hosts=current-hosts.tmp

# Generate additional-hosts
gcloud compute instance-groups list-instances ${BASE_KEY}-agent-ig --zone us-west1-b | tail -n+2 | awk '{print $1}' > ${current_hosts}
new_worker=$(python ./netsil/gen-hosts.py -a "get_new_worker" -c ${current_hosts})
start_end_ids="start_id=$new_worker end_id=$new_worker"

python ./netsil/gen-hosts.py -a "gen_new_worker_host" -n $new_worker

# Install DCOS agents
# NOTE: if this doesn't work because it can't connect to the newly created agent, just re-run it without the agent creation part
ansible-playbook -i additional-hosts add_agents.yml --extra-vars "$start_end_ids agent_type=private"

# For coreos bootstrap
ansible-playbook -i additional-hosts coreos-bootstrap.yml

# Add another agent node, scale apps
# TODO: This can be refactored so we only run it on the agent...
ansible-playbook -i additional-hosts netsil/netsil-builder/ansible/cloud-deployment.yml

# GCP specific
./netsil/gcloud/lb/00-add-instances-to-ig.sh ${BASE_KEY}-agent${new_worker}

# ADD WORKER TO NGINX
# DISABLE COREOS UPDATES
