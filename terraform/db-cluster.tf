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
    network_ip = "10.0.2.11"

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
      image = "harith-db-slave1"
    }
  }

  network_interface {
    network = "default"
    network_ip = "10.0.2.12"

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
      image = "harith-db-slave2"
    }
  }

  network_interface {
    network = "default"
    network_ip = "10.0.2.13"

    access_config {
      // Ephemeral IP
    }
  }
}
