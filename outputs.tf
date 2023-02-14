output "webpage-url" {
  value       = google_cloud_run_service.webapp.status[0].url
  description = "webapp url"
}
output "database-name" {
  value       = google_sql_database_instance.main.name
  description = "database name."
}
