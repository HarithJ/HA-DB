#!/usr/bin/env bash

setupEnvrionment () {
  printf '=========================== Setup the environment =========================== \n'

  cd ..
  sudo apt-get update
  sudo apt-get install -y postgresql
  sudo apt-get install -y postgresql-client
  sudo apt-get install -y postgresql-contrib
}

addPostgresConfs () {
  printf '=========================== Add Postgres Conf file =========================== \n'

  sudo rm -rf /etc/postgresql/9.5/main/postgresql.conf
  sudo cp /tmp/configs/postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
}

manageReplication () {
  printf '=========================== Manage replication ============================== \n'

  sudo systemctl stop postgresql
  sudo mv ../../var/lib/postgresql/9.5/main ../../var/lib/postgresql/9.5/main_old
  sudo -u postgres pg_basebackup -h 10.132.0.76 -D /var/lib/postgresql/9.5/main -U replica -v -xlog-method=stream
  sudo cp /tmp/configs/recovery.conf /var/lib/postgresql/9.5/main/recovery.conf
  sudo systemctl start postgresql
}

run () {
  setupEnvrionment
  addPostgresConfs
  manageReplication
}

run