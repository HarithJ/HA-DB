#!/usr/bin/env bash

setupEnvrionment () {
  printf '=========================== Setup the environment ======================== \n'

  sudo apt-get update
  sudo apt-get install -y haproxy
  sudo rm -rf /etc/haproxy/haproxy.cfg
  sudo cp /tmp/configs/haproxy.cfg /etc/haproxy/haproxy.cfg
  sudo systemctl restart haproxy
}

run () {
  setupEnvrionment
}

run