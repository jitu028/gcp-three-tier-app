terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.53, < 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.53, < 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.2"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-three-tier-app/v0.1.5"
  }
}

data "google_project" "project" {
  project_id = var.project_id
}
