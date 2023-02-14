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
variable "labels" {
  type        = map(string)
  description = "A map of labels for resources."
  default     = { "three-tier-app-gcp-terraform" = true }
}
