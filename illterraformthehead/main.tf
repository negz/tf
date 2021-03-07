variable "database_version" {
  default     = "POSTGRES_11"
  description = "The desired CloudSQL database version"
}

output "url" {
  value       = google_sql_database_instance.negztest.self_link
  description = "The 'self link' of the CloudSQL database"
}

provider "google" {
  project     = "crossplane-playground"
  credentials = "secret/creds.json"
}

resource "random_id" "negztest" {
  byte_length = 8
}

resource "google_sql_database_instance" "negztest" {
  name                = "negztest-${random_id.negztest.hex}"
  database_version    = var.database_version
  region              = "us-west1"
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
  }
}

