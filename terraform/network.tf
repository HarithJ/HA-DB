resource "google_compute_network" "ha-db-network" {
  name = "harith-db-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "ha-db-subnet" {
  name   = "harith-db-subnet"
  ip_cidr_range = "10.0.2.0/24"
  region = "${var.region}"
  network = "${google_compute_network.ha-db-network.self_link}"
  private_ip_google_access = "true"
}

resource "google_compute_address" "haproxy-ip" {
  name = "harith-haproxy-ip"
  region = "${var.region}"
}
