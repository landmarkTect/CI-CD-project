# main.tf

# Specify the Terraform version
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Configure the Google Cloud provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Define a Cloud SQL instance
resource "google_sql_database_instance" "default" {
  name             = "sql-instance"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }
}

# Define a Cloud Storage bucket
resource "google_storage_bucket" "static_files" {
  name     = "${var.project_id}-static-files"
  location = var.region
}

# Define a Cloud Run service
resource "google_cloud_run_service" "default" {
  name     = "php-service"
  location = var.region
  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/php-service-image"
        ports {
          container_port = 8080
        }
      }
    }
  }
}

# Define an HTTP load balancer
resource "google_compute_global_address" "default" {
  name = "global-address"
}

resource "google_compute_url_map" "default" {
  name            = "url-map"
  default_service = google_cloud_run_service.default.status[0].url
}

resource "google_compute_target_http_proxy" "default" {
  name    = "http-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "forwarding-rule"
  target     = google_compute_target_http_proxy.default.self_link
  port_range = "80"
}
