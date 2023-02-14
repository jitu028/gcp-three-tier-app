data "google_project" "project" {
  project_id = var.project_id
}

locals {
  api_image = "gcr.io/sic-container-repo/todo-api-postgres:latest"
  fe_image  = "gcr.io/sic-container-repo/todo-fe"
}