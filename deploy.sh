#!/usr/bin/env bash

# build the database master image
buildMasterImage() {
  touch master_image_output.log
  packer build packer/db-master/packer.json 2>&1 | tee master_image_output.log
  MASTER_IMG_TAG="$(grep 'A disk image was created:' master_image_output.log | cut -d' ' -f8)"
  echo $MASTER_IMG_TAG
}

# build the database slave images
buildSlaveImages() {
  touch slave1_image_output.log
  packer build packer/db-slave1/packer.json 2>&1 | tee slave1_image_output.log
  SLAVE1_IMG_TAG="$(grep 'A disk image was created:' slave1_image_output.log | cut -d' ' -f8)"
  echo $SLAVE1_IMG_TAG

  touch slave1_image_output.log
  packer build packer/db-slave2/packer.json 2>&1 | tee slave1_image_output.log
  SLAVE1_IMG_TAG="$(grep 'A disk image was created:' slave1_image_output.log | cut -d' ' -f8)"
  echo $SLAVE1_IMG_TAG
}

# build the etcd image
buildEtcdImage() {
  touch haproxy_image_output.log
  packer build packer/ectd/packer.json 2>&1 | tee haproxy_image_output.log
  HAPROXY_IMG_TAG="$(grep 'A disk image was created:' haproxy_image_output.log | cut -d' ' -f8)"
  echo $HAPROXY_IMG_TAG
}

# build the HAProxy image
buildHaproxyImage() {
  touch haproxy_image_output.log
  packer build packer/haproxy/packer.json 2>&1 | tee haproxy_image_output.log
  HAPROXY_IMG_TAG="$(grep 'A disk image was created:' haproxy_image_output.log | cut -d' ' -f8)"
  echo $HAPROXY_IMG_TAG
}

# create the infrastructre
deployImages() {
  cd terraform
  terraform init
  terraform apply
}

main () {
  buildMasterImage
  buildSlaveImages
  buildEtcdImage
  buildHaproxyImage
  deployImages
}

main
