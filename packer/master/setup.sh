#!/usr/bin/env bash

setupEnvrionment () {
  printf '=========================== Setup the environment ============================== \n'

  cd ..
  sudo apt-get update
  sudo apt-get install -y postgresql
  sudo apt-get install -y postgresql-client
  sudo apt-get install -y postgresql-contrib
}

addReplicaUser () {
  printf '=========================== Add replication user ============================== \n'

  sudo -u postgres psql -c "CREATE USER replica REPLICATION LOGIN ENCRYPTED PASSWORD 'lmsreplica';"
}

addPostgresConfs () {
  printf '=========================== Add Postgres Conf files ============================== \n'

  sudo rm -rf /etc/postgresql/9.5/main/postgresql.conf
  sudo rm -rf /etc/postgresql/9.5/main/pg_hba.conf
  sudo cp /tmp/configs/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
  sudo cp /tmp/configs/pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
}

addArchive () {
  printf '=========================== Add archives ============================== \n'

  sudo mkdir -p /var/lib/postgresql/9.5/main/archived
  sudo systemctl restart postgresql
}

run () {
  setupEnvrionment
  addReplicaUser
  addPostgresConfs
  addArchive
}

run