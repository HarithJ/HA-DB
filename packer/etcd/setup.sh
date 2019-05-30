#!/usr/bin/env bash

# The below function runs updates and installs etcd
# Etcd is a fault-tolerant, distributed key-value store that is used to store
# the state of the Postgres cluster.
installEtcd () {
  printf '=========================== Install etcd ============================== \n'

  sudo apt-get update
  sudo apt install etcd -y
}

# the below function copies etcd configuration file to the appropriate location
# and restarts etcd service
configureEtcd () {
  printf '=========================== Configure etcd ============================== \n'

  sudo cp /tmp/configs/etcd /etc/default/etcd
  sudo systemctl restart etcd
}

# this is the main function that invokes all the other functions
main () {
  installEtcd
}

main
