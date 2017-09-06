#!/bin/bash
# Install packages
sudo yum update -y google-cloud-sdk && \
sudo yum update -y && \
sudo yum install -y epel-release && \
sudo yum install -y python-pip jq && \
sudo pip install -U pip && \
sudo pip install 'apache-libcloud==1.2.1' && \
sudo pip install 'docker-py==1.9.0' && \
sudo pip install 'jinja2==2.9.6' 'pyyaml==3.12' 'pystache==0.5.4' && \
sudo yum install -y git ansible-2.3.1.0 && \
sudo yum install -y pystache && sudo ln -s /usr/bin/pystache /usr/local/bin/pystache && \
sudo yum install -y mysql mysql-server

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

# Add centos user to docker
sudo usermod -aG docker centos

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
