#!/bin/bash
export APPS_DIR=${APPS_DIR:-"/home/centos/netsil-dcos-gce/netsil/netsil-builder/apps"}

# Generate hosts file
python ./netsil/gen-hosts.py

# Generate id string
start_end_ids=$(python ./netsil/gen-hosts.py -a "gen_start_end_ids")

# Install DCOS masters
ansible-playbook -i hosts install.yml

# Install DCOS agents
ansible-playbook -i hosts add_agents.yml --extra-vars "$start_end_ids agent_type=private"

# Clone netsil-builder repo
./netsil/clone-builder.sh

# Reconfigure master and agent and start netsil cloud
ansible-playbook -i hosts netsil/netsil-builder/ansible/cloud-deployment.yml

