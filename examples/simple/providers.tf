terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7"
    }
  }
}

provider "google" {
  project = "my-gcp-project"
  region  = "europe-west1"
}
