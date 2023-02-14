resource "google_cloud_run_service" "bkd-app" {
  name     = "${var.app_name}-bkd-app"
  provider = google-beta
  location = var.region
  project  = var.project_id

  template {
    spec {
      service_account_name = google_service_account.runsa.email
      containers {
        image = "gcr.io/three-tier-app-prj/todo-bckend-app:latest"
        env {
          name  = "redis_host"
          value = google_redis_instance.main.host
        }
        env {
          name  = "db_host"
          value = google_sql_database_instance.main.ip_address[0].ip_address
        }
        env {
          name  = "db_user"
          value = google_service_account.runsa.email
        }
        env {
          name  = "db_conn"
          value = google_sql_database_instance.main.connection_name
        }
        env {
          name  = "db_name"
          value = "todo"
        }
        env {
          name  = "redis_port"
          value = "6379"
        }

      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"        = "30"
        "run.googleapis.com/cloudsql-instances"   = google_sql_database_instance.main.connection_name
        "run.googleapis.com/client-name"          = "terraform"
        "run.googleapis.com/vpc-access-egress"    = "all"
        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.main.id

      }
    }
  }
  metadata {
    labels = var.labels
  }
  autogenerate_revision_name = true
  depends_on = [
    google_sql_user.main,
    google_sql_database.database
  ]
}