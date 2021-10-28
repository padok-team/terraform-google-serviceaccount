# Create a service account for a machine

provider "google" {
  project = "padok-cloud-factory"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

module "viewer-service-account" {
  source       = "../.."
  project      = "padok-cloud-factory"
  account_id   = "viewer"
  display_name = "The global viewer service account"
  create_key   = false
  roles = [
    "roles/viewer",
  ]
}
