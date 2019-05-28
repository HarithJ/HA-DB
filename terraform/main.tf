# Specify the provider (GCP)
provider "google" {
  project     = "andela-learning"
  region      = "${var.region}"
}

resource "google_compute_address" "haproxy-ip" {
  name = "harith-haproxy-ip"
  region = "${var.region}"
}

# Create the master db instance
resource "google_compute_instance" "db-lb-master" {
  name         = "harith-db-master"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "harith-db-master"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_instance" "db-lb-slave1" {
  name         = "harith-db-slave1"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "harith-db-slave"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}

resource "google_compute_instance" "db-lb-slave2" {
  name         = "harith-db-slave2"
  machine_type = "g1-small"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "harith-db-slave"
    }
  }

  network_interface {
    network = "default"

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
      image = "haproxy-image"
    }
  }

  network_interface {
    network    = "default"
    network_ip = "${var.haproxy_internal_ip}"

    access_config {
      nat_ip = "${google_compute_address.haproxy-ip.address}"
    }
  }
}
