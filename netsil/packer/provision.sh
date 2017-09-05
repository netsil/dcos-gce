#!/bin/bash
# Install packages
sudo yum update -y google-cloud-sdk && \
sudo yum update -y && \
sudo yum install -y epel-release && \
sudo yum install -y python-pip && \
sudo pip install -U pip && \
sudo pip install 'apache-libcloud==1.2.1' && \
sudo pip install 'docker-py==1.9.0' && \
sudo yum install -y git-1.8.3.1 ansible-2.1.1.0

# Install docker
sudo tee /etc/yum.repos.d/docker.repo <<-'EOF'
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

sudo yum install -y docker-engine-1.11.2


# Reload systemd and enable docker
sudo systemctl daemon-reload
sudo systemctl enable docker.service


sudo tee /root/.ansible.cfg <<-'EOF'
[defaults]
host_key_checking = False

[paramiko_connection]
record_host_keys = False

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -o UserKnownHostsFile=/dev/null
EOF

sudo tee /home/centos/.ansible.cfg <<-'EOF'
[defaults]
host_key_checking = False

[paramiko_connection]
record_host_keys = False

[ssh_connection]
ssh_args = -o ControlMaster=auto -o ControlPersist=60s -o UserKnownHostsFile=/dev/null
EOF
