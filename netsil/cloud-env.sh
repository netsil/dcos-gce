export ZONE=$(python ./netsil/gen-env.py -e "zone")
export REGION=$(python ./netsil/gen-env.py -e "region")
export BASE_KEY=$(python ./netsil/gen-env.py -e "base_key")

# Special case: netsil-cloud-master0,netsil-cloud-master1,netsil-cloud-master2
export MASTERS=$(python ./netsil/gen-env.py -e "masters")

# Special case: netsil-cloud-agent0001,netsil-cloud-agent0002
export AGENTS=$(python ./netsil/gen-env.py -e "agents")

export MASTER_IG=${BASE_KEY}-master-ig
export AGENT_IG=${BASE_KEY}-agent-ig

# Cloudsql stuff
# Six random hex digits
rand_hash=$(openssl rand -hex 3)
export CLOUDSQL_NAME=${BASE_KEY}-userdb-${rand_hash}
export CLOUDSQL_DB_VERSION=$(python ./netsil/gen-env.py -e "cloudsql_db_version")
export CLOUDSQL_TIER=$(python ./netsil/gen-env.py -e "cloudsql_tier")
export CLOUDSQL_STORAGE_SIZE=$(python ./netsil/gen-env.py -e "cloudsql_storage_size")
export USERDB_PASSWORD_FILE=${BASE_KEY}-userdb-passwd-file

