variable "region" {
  type    = "string"
  default = "europe-west1"
}

variable "zone" {
  type    = "string"
  default = "europe-west1-b"
}

variable "haproxy_internal_ip" {
  type    = "string"
  default = "10.132.0.77"
}
