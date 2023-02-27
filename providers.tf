terraform {
  backend "gcs"{
      bucket = "kpweb1"
      prefix = "three-tier-app"
  }
}
