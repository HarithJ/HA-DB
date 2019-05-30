#!/usr/bin/env bash

installPostgress () {
  printf '=========================== Install Postgres ============================== \n'

  sudo apt-get update
  sudo apt install postgresql-9.5 -y
}

configurePostgres () {
  printf '=========================== Configure Postgres for Patroni ============================== \n'

  sudo systemctl stop postgresql
  sudo ln -s /usr/lib/postgresql/9.5/bin/* /usr/sbin/

}

installPatroni () {
  printf '=========================== Install Patroni ============================== \n'

  sudo apt install python3 python3-pip -y
  sudo pip3 install --upgrade setuptools
  sudo apt install libpq-dev -y
  sudo pip3 install patroni[etcd]

}

configurePatroni () {
  printf '=========================== Configure Postgres for Patroni ============================== \n'

  sudo cp /tmp/configs/patroni.yml /etc/patroni.yml
  sudo mkdir /data/patroni -p
  sudo chown postgres:postgres /data/patroni
  sudo chmod 700 /data/patroni
}

startPatroni () {
  printf '=========================== Start Patroni ============================== \n'

  sudo cp /tmp/configs/patroni.service /etc/systemd/system/patroni.service
  sudo systemctl start patroni
}

run () {
  installPostgress
  configurePostgres
  installPatroni
  configurePatroni
  startPatroni
}

run
