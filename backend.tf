terraform {
  required_version = ">= 1.0.0"

  backend "gcs" {
    bucket  = "09f842d25ca4f172-htc-00-gcp-tfstate"
    prefix  = "terraform/state"
  }
}
