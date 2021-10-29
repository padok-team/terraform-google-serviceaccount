provider "google" {
  project = "padok-cloud-factory"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

# Create services account for machine

module "service_account" {
  source = "../.."
  list_serviceaccount = {
    "my-first-sa" = {
      permissions = [
        "iam.roles.create",
        "iam.roles.delete",
        "iam.roles.undelete",
        "iam.roles.get",
        "iam.roles.list"
      ]
      predifined_roles = ["roles/run.admin", "roles/gkehub.gatewayAdmin"]
      description      = "Service account for managing IAM roles"
      key              = false
    }
    "my-second-sa" = {
      permissions = [
        "cloudsql.instances.get",
        "cloudsql.instances.login"
      ]
      predifined_roles = [""]
      description      = "Service account for Cloud SQL Instance"
      key              = true
    }
  }
}

output "service_account_private_key" {
  value     = module.service_account.service_account_private_key
  sensitive = true
}

output "service_account_public_key" {
  value = module.service_account.service_account_public_key
}

output "service_account_email" {
  value = module.service_account.service_account_email
}
