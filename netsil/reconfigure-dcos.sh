#!/bin/bash
export APPS_DIR=/home/centos/netsil-dcos-gce/netsil/netsil-builder/apps
export BUILDER_BRANCH=refactor-for-cloud

# Clone netsil-builder repo
./netsil/clone-builder.sh

# Reconfigure master and agent and start netsil cloud
ansible-playbook -i hosts netsil/netsil-builder/ansible/cloud-deployment.yml

