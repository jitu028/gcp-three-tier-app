terraform {
  backend "gcs"{
      bucket = "webapp-terraform-state"
      prefix = "three-tier-app"
  }
}
