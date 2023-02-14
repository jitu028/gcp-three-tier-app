variable "app_name" {
  type        = string
  description = "apps name added as prefix."
  default     = "three-tier-app-gcp-terraform"
}
variable "region" {
  type        = string
  description = "Region"
}
variable "project_id" {
  type        = string
  description = "project ID"
}