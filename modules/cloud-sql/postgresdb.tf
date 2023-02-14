resource "google_redis_instance" "main" {
  authorized_network      = google_compute_network.main.name
  connect_mode            = "DIRECT_PEERING"
  location_id             = var.zone
  memory_size_gb          = 1
  name                    = "${var.app_name}-cache"
  display_name            = "${var.app_name}-cache"
  project                 = var.project_id
  redis_version           = "REDIS_6_X"
  region                  = var.region
  reserved_ip_range       = "10.137.125.88/29"
  tier                    = "BASIC"
  transit_encryption_mode = "DISABLED"
  labels                  = var.labels
}

resource "random_id" "id" {
  byte_length = 2
}


resource "google_sql_database_instance" "main" {
  name             = "${var.app_name}-db-${random_id.id.hex}"
  database_version = "POSTGRES_14"
  region           = var.region
  project          = var.project_id

  settings {
    tier                  = "db-g1-small"
    disk_autoresize       = true
    disk_autoresize_limit = 0
    disk_size             = 10
    disk_type             = "PD_SSD"
    user_labels           = var.labels
    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/${var.project_id}/global/networks/${google_compute_network.main.name}"
    }
    location_preference {
      zone = var.zone
    }
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }
  deletion_protection = false

  depends_on = [
    google_service_networking_connection.main
  ]
}


resource "google_sql_user" "main" {
  project         = var.project_id
  name            = "${google_service_account.runsa.account_id}@${var.project_id}.iam"
  type            = "CLOUD_IAM_SERVICE_ACCOUNT"
  instance        = google_sql_database_instance.main.name
  deletion_policy = "ABANDON"
}

resource "google_sql_database" "database" {
  project         = var.project_id
  name            = "todo"
  instance        = google_sql_database_instance.main.name
  deletion_policy = "ABANDON"
}
