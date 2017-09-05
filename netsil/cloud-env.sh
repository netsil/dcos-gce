export ZONE=us-west1-b
export REGION=us-west1

export BASE_KEY=netsil-cloud-dev
export CLOUDSQL_NAME=${BASE_KEY}-userdb-rev1

# E.g. netsil-cloud-master0,netsil-cloud-master1,netsil-cloud-master2
export MASTERS=

# E.g. netsil-cloud-agent0001,netsil-cloud-agent0002
export AGENTS=

export MASTER_IG=${BASE_KEY}-master-ig
export AGENT_IG=${BASE_KEY}-agent-ig

# Cloudsql stuff
export CLOUDSQL_DB_VERSION=MYSQL_5_7
export CLOUDSQL_TIER=db-n1-standard-8
export CLOUDSQL_STORAGE_SIZE=500

export USERDB_PASSWORD_FILE=${BASE_KEY}-userdb-passwd-file
