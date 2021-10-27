variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

variable "gcloud_credentials_file" {
  type    = string
  default = "syndeno-sandbox-443555d72cd6.json"
}

provider "google" {
  credentials = var.gcloud_credentials_file
  project = var.project_id
  region  = var.region
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}
