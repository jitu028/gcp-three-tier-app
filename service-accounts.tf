resource "google_service_account" "runsa" {
  project      = var.project_id
  account_id   = "${var.app_name}-run-sa"
  display_name = "Service Account for Cloud Run"
}

resource "google_project_iam_member" "allrun" {
  for_each = toset(var.run_roles)
  project  = data.google_project.project.number
  role     = each.key
  member   = "serviceAccount:${google_service_account.runsa.email}"
}

resource "google_cloud_run_service_iam_member" "noauth_bkd-app" {
  location = google_cloud_run_service.bkd-app.location
  project  = google_cloud_run_service.bkd-app.project
  service  = google_cloud_run_service.bkd-app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_service_iam_member" "noauth_webapp" {
  location = google_cloud_run_service.webapp.location
  project  = google_cloud_run_service.webapp.project
  service  = google_cloud_run_service.webapp.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
