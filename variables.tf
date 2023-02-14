variable "project_id" {
  type        = string
  description = "project ID"
}

variable "region" {
  type        = string
  description = "Compute Region"
}

variable "zone" {
  type        = string
  description = "Compute Zone"
}

variable "app_name" {
  type        = string
  description = "prefix for app."
  default     = "todo-list"
}

variable "labels" {
  type        = map(string)
  description = "map of labels."
  default     = { "todo-list-app" = true }
}

variable "enable_apis" {
  type        = string
  description = "enable apis."
  default     = true
}

variable "run_roles" {
  description = "roles used by cloud run service"
  type        = list(string)
  default = [
    "roles/cloudsql.instanceUser",
    "roles/cloudsql.client",
  ]
}
