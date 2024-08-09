variable "gcp_project" {
  description = "The GCP project ID."
  type        = string
}

variable "gcp_service_account_key" {
  description = "Path to the GCP service account key JSON file."
  type        = string
}

variable "region" {
  description = "The region to deploy resources."
  type        = string
}

variable "db_name" {
  description = "Name of the Cloud SQL database."
  type        = string
}

variable "bucket_name" {
  description = "Name of the Cloud Storage bucket."
  type        = string
}

variable "container_image" {
  description = "Container image for the Cloud Run service."
  type        = string
}

variable "service_name" {
  description = "Name of the Cloud Run service."
  type        = string
}
