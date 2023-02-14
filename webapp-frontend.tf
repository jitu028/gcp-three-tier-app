resource "google_cloud_run_service" "webapp" {
  name     = "${var.app_name}-webapp"
  location = var.region
  project  = var.project_id

  template {
    spec {
      service_account_name = google_service_account.runsa.email
      containers {
        image = "gcr.io/three-tier-app-prj/todo-webapp:latest"
        ports {
          container_port = 80
        }
        env {
          name  = "ENDPOINT"
          value = google_cloud_run_service.bkd-app.status[0].url
        }
      }
    }
  }
  metadata {
    labels = var.labels
  }
}
