variable "project_id" {
  description = "project id"
}

variable "region" {
  description = "region"
}

#variable "gcloud_credentials_file" {
#  type    = string
#}
variable "access_token"{
  type = string 
}

provider "google" {
 # credentials = var.gcloud_credentials_file
  project = var.project_id
  region  = var.region
  access_token = var.access_token
}

# VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}--vpc"
  auto_create_subnetworks = "false"
}

# Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.0.0/24"
}
