terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.52.0"
    }
  }
  backend "gcs" {
    bucket = "syndeno-sandbox-tfstate"
    prefix = "jenkins"
  }
}

