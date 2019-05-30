# Specify the provider (GCP)
provider "google" {
  project     = "andela-learning"
  region      = "${var.region}"
}

resource "google_compute_instance" "etcd" {
  name         = "harith-etcd"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "harith-etcd"
    }
  }

  network_interface {
    network = "default"
    network_ip = "10.0.2.21"

    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_instance" "haproxy-db-lb" {
  name         = "harith-haproxy"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "harith-haproxy"
    }
  }

  network_interface {
    network    = "default"
    network_ip = "10.0.2.31"

    access_config {
      nat_ip = "${google_compute_address.haproxy-ip.address}"
    }
  }
}
