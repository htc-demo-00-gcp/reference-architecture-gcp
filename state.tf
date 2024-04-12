locals {
  backend_config = <<EOT
terraform {
  required_version = ">= 1.0.0"

  backend "gcs" {
    bucket  = "${google_storage_bucket.terraform_state.name}"
    prefix  = "terraform/state"
  }
}
EOT
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "terraform_state" {
  name          = "${random_id.bucket_prefix.hex}-htc-00-gcp-tfstate"
  location      = "EU"
  force_destroy = false

  versioning {
    enabled = true
  }

  public_access_prevention = "enforced"
}

resource "local_file" "terraform_backend_config" {
  content         = local.backend_config
  filename        = "backend.tf"
  file_permission = "0644"
}
