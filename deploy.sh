#!/usr/bin/env bash

buildMasterImage() {
  touch master_image_output.log
  packer build packer/master/packer.json 2>&1 | tee master_image_output.log
  MASTER_IMG_TAG="$(grep 'A disk image was created:' master_image_output.log | cut -d' ' -f8)"
  echo $MASTER_IMG_TAG
}

buildSlaveImage() {
  touch slave1_image_output.log
  packer build packer/slaves/packer.json 2>&1 | tee slave1_image_output.log
  SLAVE1_IMG_TAG="$(grep 'A disk image was created:' slave1_image_output.log | cut -d' ' -f8)"
  echo $SLAVE1_IMG_TAG
}

buildHaproxyImage() {
  touch haproxy_image_output.log
  packer build packer/slaves/packer.json 2>&1 | tee haproxy_image_output.log
  HAPROXY_IMG_TAG="$(grep 'A disk image was created:' haproxy_image_output.log | cut -d' ' -f8)"
  echo $HAPROXY_IMG_TAG
}

deployImages() {
  cd terraform
  terraform init
  terraform apply
}

run () {
  buildMasterImage
  buildSlaveImage
  buildHaproxyImage
  deployImages
}

run
