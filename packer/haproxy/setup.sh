#!/usr/bin/env bash

# The below function installs HAProxy
installHaProxy () {
  printf '=========================== Install HAProxy ======================== \n'

  sudo apt-get update
  sudo apt-get install -y haproxy
}

# The below function copies the HAProxy's config file to the appropriate location
# and it restarts the HAProxy service
configureHaProxy () {
  printf '=========================== Configure HAProxy ======================== \n'

  sudo rm -rf /etc/haproxy/haproxy.cfg
  sudo cp /tmp/configs/haproxy.cfg /etc/haproxy/haproxy.cfg
  sudo systemctl restart haproxy
}

# main function invokes all the other functions
main () {
  installHaProxy
  configureHaProxy
}

main
