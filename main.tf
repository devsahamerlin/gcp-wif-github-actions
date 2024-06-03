terraform {
  cloud {
    organization = "devsahamerlin"

    workspaces {
      name = "tfc-mongodb"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

variable "gcp_project_id" {}

variable "gcp_region" {
  default = "us-east4"
}

variable "gcp_zone" {
  default = "us-east4-c"
}

resource "google_compute_instance" "test-instance" {
  name         = "test-instance"
  machine_type = "n1-standard-1"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size = 20
    }
  }

  network_interface {
    subnetwork = "default"
  }
}

# generate terraform resource to create gcp bucket
resource "google_storage_bucket" "bucket" {
  name     = "tfc-mongodb-bucket"
  location = "US"
  storage_class = "STANDARD"
}
